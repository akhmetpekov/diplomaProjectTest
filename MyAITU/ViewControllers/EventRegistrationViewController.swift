//
//  EventRegistrationViewController.swift
//  MyAITU
//
//  Created by Erik on 20.05.2024.
//

import UIKit
import WebKit
import SnapKit

class EventRegistrationViewController: UIViewController {
    
    private let registrationLink: String
    
    init (registrationLink: String) {
        self.registrationLink = registrationLink
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        guard let url = URL(string: registrationLink) else { return }
        webView.load(URLRequest(url: url))
    }
    
    private func setupUI() {
        title = "Register To Event"
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


