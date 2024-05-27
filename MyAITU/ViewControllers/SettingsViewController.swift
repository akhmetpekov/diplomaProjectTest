//
//  SettingsViewController.swift
//  MyAITU
//
//  Created by Erik on 20.05.2024.
//

import UIKit
import SnapKit
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    private let darkThemeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.text = "Dark Theme:"
        return label
    }()
    
    private let themeSwitch: UISwitch = {
        let themeSwitch = UISwitch()
        themeSwitch.isOn = true
        return themeSwitch
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        let attributedTitle = NSAttributedString(
            string: "Logout",
            attributes: [
                .font: UIFont.systemFont(ofSize: 20, weight: .bold),
                .foregroundColor: UIColor.white
            ]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.configuration?.baseBackgroundColor = Resources.Colors.logoutButtonBackground
        button.configuration?.baseForegroundColor = .white
        button.configuration?.buttonSize = .large
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureConstraints()
    }
    
    @objc private func logoutButtonTapped() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            NotificationCenter.default.post(name: Notification.Name("logoutSuccess"), object: nil)
            navigationController?.popViewController(animated: true)
        } catch {
            print("Error when signing out")
        }
    }
    
    private func setupUI() {
        title = "Settings"
        view.backgroundColor = Resources.Colors.background
        view.addSubview(darkThemeLabel)
        view.addSubview(themeSwitch)
        view.addSubview(logoutButton)
    }
    
    private func configureConstraints() {
        darkThemeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        themeSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(darkThemeLabel)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
}
