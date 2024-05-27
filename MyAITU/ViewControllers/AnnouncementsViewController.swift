//
//  AnnouncementsViewController.swift
//  MyAITU
//
//  Created by Erik on 06.05.2024.
//

import UIKit
import FirebaseFirestore

class AnnouncementsViewController: UIViewController {
    
    let db = Firestore.firestore()
    var announcementsData = [Announcement]()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AnnouncementsCell.self, forCellReuseIdentifier: AnnouncementsCell.identifier)
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
        title = "Announcements"
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
        db.collection("announcements").getDocuments { (querySnapshot, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(String(describing: error))
                } else {
                    self.announcementsData = querySnapshot?.documents.compactMap { document in
                        let doc = Announcement(dictionary: document.data())
                        return doc
                    } ?? []
                    self.loadingIndicator.stopAnimating()
                    self.tableView.reloadData()  // Reload table view after fetching data
                }
            }
        }
    }
}

extension AnnouncementsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcementsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnnouncementsCell.identifier, for: indexPath) as? AnnouncementsCell else {
            fatalError("Events cell not working")
        }
        
        let announce = announcementsData[indexPath.row]
//        let date = event.date
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "YY/MM/dd"
        cell.setupCell(bannerImage: announce.banner_url, title: announce.title, date: "", description: announce.description, has_banner: announce.has_banner)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}


