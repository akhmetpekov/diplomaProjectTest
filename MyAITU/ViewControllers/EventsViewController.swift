//
//  EventsViewController.swift
//  MyAITU
//
//  Created by Erik on 06.05.2024.
//

import UIKit
import FirebaseFirestore

class EventsViewController: UIViewController {
    
//    var eventsData = Events.getEvents()
    let db = Firestore.firestore()
    var eventsData = [Event]()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let tableView: UITableView = {
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
        fetchData()
        setupUI()
        configureConstraints()
    }
    
    private func setupUI() {
        title = "Events"
        view.backgroundColor = Resources.Colors.background
        view.addSubview(tableView)
        tableView.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()

    }
    
    private func configureConstraints() {
        loadingIndicator.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    private func fetchData() {
        db.collection("events").getDocuments { (querySnapshot, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(String(describing: error))
                } else {
                    self.eventsData = querySnapshot?.documents.compactMap { document in
                        let doc = Event(dictionary: document.data())
                        return doc
                    } ?? []
                    self.loadingIndicator.stopAnimating()
                    self.tableView.reloadData()  // Reload table view after fetching data
                }
            }
        }
    }
}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventsCell.identifier, for: indexPath) as? EventsCell else {
            fatalError("Events cell not working")
        }
        
        let event = eventsData[indexPath.row]
//        let date = event.date
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "YY/MM/dd"
        cell.setupCell(bannerImage: event.banner_url, title: event.title, date: "", description: event.description)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let event = eventsData[indexPath.row]
        let vc = EventsDetailViewController(title: event.title, banner: event.banner_url, description: event.description, date: "", registrationLink: event.registration_link)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
