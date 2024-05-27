//
//  UniversityMapViewController.swift
//  MyAITU
//
//  Created by Erik on 06.05.2024.
//

import UIKit
import SnapKit
import PDFKit

class UniversityMapViewController: UIViewController {
    
    private let pdfView: PDFView = {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.backgroundColor = Resources.Colors.background
        return pdfView
    }()
    
    private lazy var floorSegment: UISegmentedControl = {
        let items = ["First", "Second", "Third"]
        let segment = UISegmentedControl(items: items)
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(floorChanged), for: .valueChanged)
        return segment
    }()
    
    private let floorLabel: UILabel = {
        let label = UILabel()
        label.text = "Floor"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = Resources.Colors.cardBackground
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureConstraints()
        configurePDF()
        
    }
    
    private func setupUI() {
        title = "University Map"
        view.backgroundColor = Resources.Colors.background
        view.addSubview(floorLabel)
        view.addSubview(floorSegment)
        view.addSubview(pdfView)
    }
    
    private func configureConstraints() {
        floorLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
        }
        
        floorSegment.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(floorLabel.snp.bottom).offset(15)
        }
        
        pdfView.snp.makeConstraints { make in
            make.top.equalTo(floorSegment.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(30)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func configurePDF() {
        guard let path = Bundle.main.url(forResource: "uni map 1 floor", withExtension: "pdf") else { return }
        if let document = PDFDocument(url: path) {
            pdfView.document = document
        }
    }
    
    @objc private func floorChanged() {
        switch floorSegment.selectedSegmentIndex {
        case 0:
            guard let path = Bundle.main.url(forResource: "uni map 1 floor", withExtension: "pdf") else { return }
            if let document = PDFDocument(url: path) {
                pdfView.document = document
                pdfView.autoScales = true
//                pdfView.reloadInputViews()
            }
        case 1:
            guard let path = Bundle.main.url(forResource: "uni map 2 floor", withExtension: "pdf") else { return }
            if let document = PDFDocument(url: path) {
                pdfView.document = document
                pdfView.autoScales = true
//                pdfView.reloadInputViews()
            }
        case 2:
            guard let path = Bundle.main.url(forResource: "uni map 3 floor", withExtension: "pdf") else { return }
            if let document = PDFDocument(url: path) {
                pdfView.document = document
                pdfView.autoScales = true
//                pdfView.reloadInputViews()
            }
        default:
            guard let path = Bundle.main.url(forResource: "uni map 1 floor", withExtension: "pdf") else { return }
            if let document = PDFDocument(url: path) {
                pdfView.document = document
                pdfView.autoScales = true
//                pdfView.reloadInputViews()
            }
        }
    }
}



