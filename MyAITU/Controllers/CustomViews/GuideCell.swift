//
//  CustomCell.swift
//  MyAITU
//
//  Created by Erik on 19.05.2024.
//

import UIKit

class GuideCell: UITableViewCell {
    static let identifier = "GuideCell"
    
    private let primaryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private let paddingView: UIView = {
        let paddingView = UIView()
        paddingView.backgroundColor = Resources.Colors.buttonBackground
        return paddingView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        configureConstraints()
    }
    
    
    
    func setupCell(label: String, iconName: String) {
        primaryLabel.text = label
        let largeFont = UIFont.systemFont(ofSize: 20)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        if iconName == "teams" || iconName == "logoAitu" {
            let iconImage = UIImage(named: iconName)
            icon.image = iconImage
        } else {
            let iconImage = UIImage(systemName: iconName, withConfiguration: configuration)
            icon.image = iconImage
        }
    }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(paddingView)
        paddingView.addSubview(primaryLabel)
        paddingView.addSubview(icon)
    }
    
    private func configureConstraints() {
        paddingView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        icon.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        
        primaryLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(icon.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        paddingView.layer.masksToBounds = true
        paddingView.layer.cornerRadius = 14
        layer.masksToBounds = true
        layer.cornerRadius = 14
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
