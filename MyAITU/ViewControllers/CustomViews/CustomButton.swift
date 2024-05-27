//
//  CustomButton.swift
//  MyAITU
//
//  Created by Erik on 06.05.2024.
//

import UIKit
import SnapKit

class CustomButton: UIButton {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureConstraints()
    }
    
    func configure(title: String, image: String) {
        primaryLabel.text = title
        let largeFont = UIFont.systemFont(ofSize: 20)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let iconImage = UIImage(systemName: image, withConfiguration: configuration)
        icon.image = iconImage
    }
    
    private func setupUI() {
        backgroundColor = Resources.Colors.buttonBackground
        addSubview(primaryLabel)
        addSubview(icon)
    }
    
    private func configureConstraints() {
        icon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7)
            make.centerX.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        primaryLabel.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(3)
            make.centerX.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = 14
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
