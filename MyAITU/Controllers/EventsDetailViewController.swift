//
//  EventsDetailViewController.swift
//  MyAITU
//
//  Created by Erik on 19.05.2024.
//

import UIKit
import SnapKit

class EventsDetailViewController: UIViewController {
    
    private let registrationLink: String?
    
    init(title: String, banner: String, description: String, date: String, registrationLink: String?) {
        eventTitle.text = title
        bannerImageView.image = UIImage(named: banner)
        descriptionTextView.text = description
        dateLabel.text = date
        self.registrationLink = registrationLink
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var contentSize: CGSize = {
        CGSize(width: view.frame.width, height: view.frame.height + 50)
    }()
    
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .thin)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private let eventTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        textView.showsHorizontalScrollIndicator = false
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.isUserInteractionEnabled = false
        textView.textContainer.maximumNumberOfLines = 14
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.backgroundColor = .clear
        return textView
    }()
    
    private lazy var registerToEventButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        let attributedTitle = NSAttributedString(
            string: "Register To Event",
            attributes: [
                .font: UIFont.systemFont(ofSize: 20, weight: .bold),
                .foregroundColor: UIColor.white
            ]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.configuration?.baseBackgroundColor = Resources.Colors.cardBackground
        button.configuration?.baseForegroundColor = .white
        button.configuration?.buttonSize = .large
        button.addTarget(self, action: #selector(registerToEventButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if registrationLink == "" {
            registerToEventButton.isHidden = true
        }
        setupUI()
        configureConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = Resources.Colors.background
        view.addSubview(bannerImageView)
        view.addSubview(eventTitle)
        view.addSubview(descriptionTextView)
        view.addSubview(dateLabel)
        view.addSubview(registerToEventButton)
    }
    
    private func configureConstraints() {
        bannerImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(300)
        }
        
        eventTitle.snp.makeConstraints { make in
            make.top.equalTo(bannerImageView.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(eventTitle.snp.bottom).offset(3)
            make.leading.equalTo(eventTitle)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.leading.equalTo(eventTitle).offset(-3)
            make.trailing.equalToSuperview().offset(-3)
            make.height.equalTo(300)
        }
        
        registerToEventButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
    
    @objc private func registerToEventButtonTapped() {
        guard let link = registrationLink else { return }
        let vc = EventRegistrationViewController(registrationLink: link)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
