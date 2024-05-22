//
//  AnnouncementsViewController.swift
//  MyAITU
//
//  Created by Erik on 06.05.2024.
//

import UIKit

class AnnouncementsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureConstraints()
    }
    
    private func setupUI() {
        title = "Announcements"
        view.backgroundColor = Resources.Colors.background
    }
    
    private func configureConstraints() {
        
    }
}

