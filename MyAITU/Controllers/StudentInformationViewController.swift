//
//  StudentInformationViewController.swift
//  MyAITU
//
//  Created by Erik on 08.05.2024.
//

import UIKit
import SnapKit

class StudentInformationViewController: UIViewController {
    
    var student = Student.getStudentInfo()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = Resources.Colors.background
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .systemGray
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
        let studentInfo = student[0] // Assuming you have only one student in your array
        switch indexPath.row {
        case 0:
            content.text = "ФИО"
            content.secondaryText = studentInfo.FIO
        case 1:
            content.text = "ИИН"
            content.secondaryText = studentInfo.IIN
        case 2:
            content.text = "Дата Рождения"
            content.secondaryText = studentInfo.birthdate
        case 3:
            content.text = "Пол"
            content.secondaryText = studentInfo.sex
        case 4:
            content.text = "Национальность"
            content.secondaryText = studentInfo.nationality
        case 5:
            content.text = "Гражданство"
            content.secondaryText = studentInfo.citizen
        case 6:
            content.text = "Адрес"
            content.secondaryText = studentInfo.address
        case 7:
            content.text = "Группа"
            content.secondaryText = studentInfo.group
        case 8:
            content.text = "Курс"
            content.secondaryText = studentInfo.course
        case 9:
            content.text = "Степень"
            content.secondaryText = studentInfo.degree
        case 10:
            content.text = "Департамент"
            content.secondaryText = studentInfo.departament
        case 11:
            content.text = "Почта"
            content.secondaryText = studentInfo.email
        default:
            break
        }
        cell.contentConfiguration = content
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return cell
    }
    
}
