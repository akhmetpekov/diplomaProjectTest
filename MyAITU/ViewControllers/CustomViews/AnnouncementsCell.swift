//
//  AnnouncementsCell.swift
//  MyAITU
//
//  Created by Erik on 25.05.2024.
//

import UIKit
import SDWebImage

class AnnouncementsCell: UITableViewCell {
    static let identifier = "AnnouncementsCell"
    
    private let eventCard: UIView = {
        let cardView = UIView()
        cardView.backgroundColor = Resources.Colors.secondaryPrimary
        return cardView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .white
        label.text = "22.08.2024"
        label.textAlignment = .left
        return label
    }()
    
    private let eventTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.showsHorizontalScrollIndicator = false
        textView.isUserInteractionEnabled = false
        textView.textContainer.maximumNumberOfLines = 4
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.backgroundColor = .clear
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        configureConstraints()
    }
    
    func setupCell(bannerImage: String, title: String, date: String, description: String, has_banner: Bool) {
        eventTitle.text = title
        descriptionTextView.text = description
    }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(eventCard)
        eventCard.addSubview(eventTitle)
        eventCard.addSubview(dateLabel)
        eventCard.addSubview(descriptionTextView)
    }
    
    private func configureConstraints() {
        eventCard.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        eventTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.height.equalTo(80)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(eventTitle.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        eventCard.layer.masksToBounds = true
        eventCard.layer.cornerRadius = 14
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
