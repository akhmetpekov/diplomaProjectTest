//
//  GuideViewController.swift
//  MyAITU
//
//  Created by Erik on 06.05.2024.
//

import UIKit
import SnapKit

class GuideViewController: UIViewController {
    
    var guideCategories = GuideCategories.getGuideCategories()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(GuideCell.self, forCellReuseIdentifier: GuideCell.identifier)
        tableView.backgroundColor = Resources.Colors.background
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.showsHorizontalScrollIndicator = false
        tableView.isUserInteractionEnabled = true
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
        title = "Student Life Guide"
        view.backgroundColor = Resources.Colors.background
        view.addSubview(tableView)
    }
    
    private func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}

extension GuideViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guideCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GuideCell.identifier, for: indexPath) as? GuideCell else { fatalError("something went wrong") }
        cell.setupCell(label: guideCategories[indexPath.row].title, iconName: guideCategories[indexPath.row].icon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let inset: CGFloat = 30 // Set your desired inset value here
        cell.contentView.layoutMargins = UIEdgeInsets(top: inset, left: 0, bottom: inset, right: 0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = GuideDetailViewController(pdfName: guideCategories[indexPath.row].title)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

