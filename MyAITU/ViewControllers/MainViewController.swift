//
//  ViewController.swift
//  MyAITU
//
//  Created by Erik on 06.05.2024.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseFirestore
import SDWebImage


class MainViewController: UIViewController {
    let db = Firestore.firestore()
    var studentData = Student()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        validateAuth()
    }
    
    private let studentCard: UIView = {
        let card = UIView()
        card.isUserInteractionEnabled = true
        card.layer.masksToBounds = true
        card.backgroundColor = Resources.Colors.cardBackground
        card.layer.cornerRadius = 14
        return card
    }()
    
    private let studentImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 14
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
//        imageView.image = UIImage(named: "Student")
        return imageView
    }()
    
    private let studentName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Fetching Data"
        return label
    }()
    
    private let studentBarcode: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Barcode: Fetching Data"
        return label
    }()
    
    private lazy var eventsButton: CustomButton = {
        let button = CustomButton()
        button.configure(title: "Events", image: "calendar")
        button.addTarget(self, action: #selector(eventsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var moodleButton: CustomButton = {
        let button = CustomButton()
        button.configure(title: "Moodle", image: "graduationcap.fill")
        button.addTarget(self, action: #selector(moodleButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var universityMapButton: CustomButton = {
        let button = CustomButton()
        button.configure(title: "Map", image: "map.fill")
        button.addTarget(self, action: #selector(universityMapButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var guideButton: CustomButton = {
        let button = CustomButton()
        button.configure(title: "Guide", image: "book.pages.fill")
        button.addTarget(self, action: #selector(guideButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var digitalUniversityButton: CustomButton = {
        let button = CustomButton()
        button.configure(title: "Digital University", image: "graduationcap.fill")
        button.addTarget(self, action: #selector(digitalUniversityButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var calculatorButton: CustomButton = {
        let button = CustomButton()
        button.configure(title: "Calculator", image: "plus")
        button.addTarget(self, action: #selector(calculatorButtonTapped), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleLoginSuccess), name: Notification.Name("loginSuccess"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleLogutSuccess), name: Notification.Name("logoutSuccess"), object: nil)
        setupUI()
        configureConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(studentCardTapped))
        studentCard.addGestureRecognizer(tapGesture)
    }
    
    @objc private func eventsButtonTapped() {
        let vc = EventsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func announcementsButtonTapped() {
        let vc = AnnouncementsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func moodleButtonTapped() {
        let vc = MoodleViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func universityMapButtonTapped() {
        let vc = UniversityMapViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func guideButtonTapped() {
        let vc = GuideViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func studentCardTapped() {
        let vc = StudentInformationViewController(studentData: studentData)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func settingsButtonTapped() {
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func digitalUniversityButtonTapped() {
        let vc = DUViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func calculatorButtonTapped() {
        let vc = CalculatorViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func handleLoginSuccess() {
        fetchData()
    }
    
    @objc private func handleLogutSuccess() {
        studentImage.image = nil
        studentName.text = "Fetching Data"
        studentBarcode.text = "Barcode: Fetching Data"
    }
    
    private func getUserID() -> String {
        guard let userID = Auth.auth().currentUser?.uid else { return ""}
        print(userID)
        return userID
    }
    
    private func fetchData() {
        db.collection("students").document(getUserID()).getDocument { [weak self] (querySnapshot, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(String(describing: error))
                } else {
                    guard let data = querySnapshot?.data() else { return }
                    self?.studentData = Student(dictionary: data) ?? Student()
                    guard let studentImage = self?.studentData.student_image else { return }
                    if let url = URL(string: studentImage) {
                        self?.studentImage.sd_setImage(with: url, placeholderImage: nil, options: .highPriority, completed: nil)
                    }
                    guard let barcode = self?.studentData.barcode else { return }
                    let studentName = "\(self?.studentData.surname_cyrillic ?? "Fetching") \(self?.studentData.name_cyrillic ?? "")"
                    self?.studentBarcode.text = "Barcode: \(barcode)"
                    self?.studentName.text = studentName
                }
            }
        }
    }

    
    private func setupUI() {
        fetchData()
        configureBarButtonItems()
        view.backgroundColor = Resources.Colors.background
        studentCard.addSubview(studentImage)
        studentCard.addSubview(studentName)
        studentCard.addSubview(studentBarcode)
        view.addSubview(studentCard)
        view.addSubview(eventsButton)
        view.addSubview(moodleButton)
        view.addSubview(universityMapButton)
        view.addSubview(guideButton)
        view.addSubview(digitalUniversityButton)
        view.addSubview(calculatorButton)
    }
    
    private func configureConstraints() {
        studentCard.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.width.equalTo(350)
            make.height.equalTo(184)
        }
        
        studentImage.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(128)
            make.top.equalToSuperview().offset(27)
            make.leading.equalToSuperview().offset(20)
        }
        
        studentName.snp.makeConstraints { make in
            make.leading.equalTo(studentImage.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(71)
        }
        
        studentBarcode.snp.makeConstraints { make in
            make.leading.equalTo(studentImage.snp.trailing).offset(16)
            make.top.equalTo(studentName.snp.bottom).offset(2)
        }
        
        eventsButton.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.centerX).offset(10)
            make.top.equalTo(studentCard.snp.bottom).offset(60)
            make.width.equalToSuperview().dividedBy(2.5)
            make.height.equalTo(82)
        }
        
        moodleButton.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(2.5)
            make.height.equalTo(82)
            make.centerY.equalTo(eventsButton)
            make.trailing.equalTo(view.snp.centerX).offset(-10)
        }
        
        universityMapButton.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(2.5)
            make.height.equalTo(82)
            make.centerX.equalTo(moodleButton)
            make.top.equalTo(moodleButton.snp.bottom).offset(20)
        }
        
        guideButton.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(2.5)
            make.height.equalTo(82)
            make.centerX.equalTo(eventsButton)
            make.top.equalTo(eventsButton.snp.bottom).offset(20)
        }
        
        digitalUniversityButton.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(2.5)
            make.height.equalTo(82)
            make.centerX.equalTo(universityMapButton)
            make.top.equalTo(universityMapButton.snp.bottom).offset(20)
        }
        
        calculatorButton.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(2.5)
            make.height.equalTo(82)
            make.centerX.equalTo(guideButton)
            make.top.equalTo(guideButton.snp.bottom).offset(20)
        }
    }
    
    private func configureBarButtonItems() {
        let label1 = UIButton(type: .system)
        label1.configuration = .plain()
        label1.tintColor = .white
        label1.configuration?.image = UIImage(systemName: "bell.fill")
        label1.addTarget(self, action: #selector(announcementsButtonTapped), for: .touchUpInside)
        let infoLabel = UIBarButtonItem(customView: label1)
        
        let settings = UIButton(type: .system)
        settings.configuration = .plain()
        settings.configuration?.baseForegroundColor = .white
        settings.configuration?.image = UIImage(systemName: "gear")
        settings.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        let settingsBtn = UIBarButtonItem(customView: settings)
        
        navigationItem.rightBarButtonItems = [infoLabel, settingsBtn]
    }
    
    private func validateAuth() {
        if  FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("loginSuccess"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("logoutSuccess"), object: nil)
    }
}

