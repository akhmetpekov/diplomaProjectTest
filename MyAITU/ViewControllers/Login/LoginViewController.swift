//
//  LoginViewController.swift
//  MyAITU
//
//  Created by Erik on 20.05.2024.
//

import UIKit
import SnapKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "aituBanner")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let stackView: UIView = {
        let stackView = UIView()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: Resources.Colors.secondaryGray]
        )
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.textColor = .black
        textField.backgroundColor = .clear
        textField.keyboardType = .emailAddress
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: Resources.Colors.secondaryGray]
        )
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.textColor = .black
        textField.backgroundColor = .clear
        textField.returnKeyType = .done
        textField.setLeftPaddingPoints(10)
        textField.setRightPaddingPoints(40)
        textField.rightView = showPasswordButton
        textField.rightViewMode = .always
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign in to MyAITU", for: .normal)
        button.tintColor = .black
        button.backgroundColor = Resources.Colors.thirdPrimary
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var showPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.tintColor = .black
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return button
    }()
    
    private let alert: UIAlertController = {
        let alert = UIAlertController(title: "My Alert", message: "This is Alert message", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(cancel)
        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        loginTextField.delegate = self
        passwordTextField.delegate = self
        setupUI()
        configureConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        loginTextField.layer.masksToBounds = true
        loginTextField.layer.cornerRadius = 12
        loginTextField.layer.borderColor = UIColor.black.cgColor
        loginTextField.layer.borderWidth = 1
        passwordTextField.layer.masksToBounds = true
        passwordTextField.layer.cornerRadius = 12
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.borderWidth = 1
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 12
    }
    
    @objc private func loginButtonTapped() {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        
        guard let email = loginTextField.text, let password = passwordTextField.text, !email.isEmpty, !password.isEmpty else {
            presentAlert(title: "Error", message: "Email and password fields cannot be empty.")
            return
        }
        
        if !email.hasSuffix("@astanait.edu.kz") {
            presentAlert(title: "Invalid Email", message: "Please enter a valid AITU email address.")
            return
        }
        
        if password.count < 6 {
            presentAlert(title: "Invalid Password", message: "Your password should contain more than 6 characters")
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let result = authResult, error == nil else {
                self?.presentAlert(title: "Wrong Credentials", message: "Your Email or Password is wrong. Please check them again")
                return
            }
            
            let user = result.user
            NotificationCenter.default.post(name: Notification.Name("loginSuccess"), object: nil)
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        let buttonImageName = passwordTextField.isSecureTextEntry ? "eye.fill" : "eye.slash.fill"
        showPasswordButton.setImage(UIImage(systemName: buttonImageName), for: .normal)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(stackView)
        stackView.addSubview(loginTextField)
        stackView.addSubview(passwordTextField)
        stackView.addSubview(loginButton)
    }
    
    private func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(100)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-60)
            make.height.equalTo(200)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(15)
            make.width.equalToSuperview()
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(60)
        }
    
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            loginButtonTapped()
        }
        return true
    }
}

