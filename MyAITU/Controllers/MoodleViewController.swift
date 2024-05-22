//
//  MoodleViewController.swift
//  MyAITU
//
//  Created by Erik on 06.05.2024.
//

import UIKit
import WebKit
import SnapKit

class MoodleViewController: UIViewController {
    
    private let webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        configuration.websiteDataStore = WKWebsiteDataStore.default()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureConstraints()
        guard let url = URL(string: "https://moodle.astanait.edu.kz/") else { return }
        webView.load(URLRequest(url: url))
    }
    
    private func setupUI() {
        title = "Moodle"
        view.backgroundColor = Resources.Colors.background
        view.addSubview(webView)
    }
    
    private func configureConstraints() {
        webView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}

