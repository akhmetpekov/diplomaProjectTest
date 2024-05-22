//
//  EventsViewController.swift
//  MyAITU
//
//  Created by Erik on 06.05.2024.
//

import UIKit
import CDMarkdownKit

class EventsViewController: UIViewController {
    
    var eventsData = Events.getEvents()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(EventsCell.self, forCellReuseIdentifier: EventsCell.identifier)
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
        title = "Events"
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

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventsCell.identifier, for: indexPath) as? EventsCell else { fatalError("Events cell not wroking") }
        let event = eventsData[indexPath.row]
        cell.setupCell(bannerImage: event.bannerImage, author: event.author, date: event.date, description: event.description)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let event = eventsData[indexPath.row]
        let vc = EventsDetailViewController(title: event.author, banner: event.bannerImage, description: event.description, date: event.date, registrationLink: event.registrationLink)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
