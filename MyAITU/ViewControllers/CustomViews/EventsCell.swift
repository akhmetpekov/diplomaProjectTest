//
//  EventsCell.swift
//  MyAITU
//
//  Created by Erik on 19.05.2024.
//

import UIKit
import SDWebImage

class EventsCell: UITableViewCell {
    static let identifier = "EventsCell"
    
    private let eventCard: UIView = {
        let cardView = UIView()
        cardView.backgroundColor = Resources.Colors.secondaryPrimary
        return cardView
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
    
    func setupCell(bannerImage: String, title: String, date: String, description: String) {
        if let url = URL(string: bannerImage) {
            bannerImageView.sd_setImage(with: url, placeholderImage: nil, options: .highPriority, completed: nil)
        }
        eventTitle.text = title
        dateLabel.text = date
        descriptionTextView.text = description
    }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(eventCard)
        eventCard.addSubview(bannerImageView)
        eventCard.addSubview(eventTitle)
        eventCard.addSubview(dateLabel)
        eventCard.addSubview(descriptionTextView)
    }
    
    private func configureConstraints() {
        eventCard.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalTo(dateLabel.snp.bottom).offset(10)
        }
        
        bannerImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(190)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        eventTitle.snp.makeConstraints { make in
            make.top.equalTo(bannerImageView.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(eventTitle.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.height.equalTo(80)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(-10)
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        eventCard.layer.masksToBounds = true
        eventCard.layer.cornerRadius = 14
        bannerImageView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
