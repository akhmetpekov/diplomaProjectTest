//
//  StudentInformationViewController.swift
//  MyAITU
//
//  Created by Erik on 08.05.2024.
//

import UIKit
import FirebaseFirestore
import SnapKit
import FirebaseAuth

class StudentInformationViewController: UIViewController {
    
    private let studentData: Student
    
    init(studentData: Student) {
        self.studentData = studentData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = Resources.Colors.background
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = Resources.Colors.secondaryGray
        tableView.isScrollEnabled = true
        tableView.isUserInteractionEnabled = true
        tableView.allowsSelection = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
        configureConstraints()
        configureTabItems()
    }
    
    private func setupUI() {
        title = "Student Information"
        view.backgroundColor = Resources.Colors.background
        view.addSubview(tableView)
    }
    
    private func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func configureTabItems() {
        let logout = UIButton(type: .system)
        logout.configuration = .filled()
        logout.configuration?.baseBackgroundColor = Resources.Colors.logoutButtonBackground
        logout.configuration?.title = "Logout"
        logout.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
//        logout.configuration?.image = UIImage(systemName: "house")
        let logoutBtn = UIBarButtonItem(customView: logout)
        navigationItem.rightBarButtonItem = logoutBtn
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
}

extension StudentInformationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = Resources.Colors.background
        var content = cell.defaultContentConfiguration()
        content.textProperties.color = .white
        content.textProperties.font = .systemFont(ofSize: 16, weight: .thin)
        content.secondaryTextProperties.color = .white
        content.secondaryTextProperties.font = .systemFont(ofSize: 16, weight: .regular)
        
        switch indexPath.row {
        case 0:
            content.text = "ФИО"
            content.secondaryText = studentData.FIO
        case 1:
            content.text = "ИИН"
            content.secondaryText = studentData.IIN
        case 2:
            content.text = "Дата Рождения"
            content.secondaryText = studentData.birthdate
        case 3:
            content.text = "Пол"
            content.secondaryText = studentData.gender
        case 4:
            content.text = "Финансирование"
            content.secondaryText = studentData.financing
        case 5:
            content.text = "Телефон"
            content.secondaryText = studentData.phone
        case 6:
            content.text = "ОП"
            content.secondaryText = studentData.education_program
        case 7:
            content.text = "Группа"
            content.secondaryText = studentData.group
        case 8:
            content.text = "Курс"
            content.secondaryText = studentData.course
        case 9:
            content.text = "Степень"
            content.secondaryText = studentData.degree
        case 10:
            content.text = "Департамент"
            content.secondaryText = studentData.department
        case 11:
            content.text = "Почта"
            content.secondaryText = studentData.email
        default:
            content.text = "Now working"
            content.secondaryText = "Not"
        }
        cell.contentConfiguration = content
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return cell
    }
    
}
