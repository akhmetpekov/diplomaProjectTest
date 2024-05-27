//
//  GuideDetailViewController.swift
//  MyAITU
//
//  Created by Erik on 19.05.2024.
//

import UIKit
import PDFKit

class GuideDetailViewController: UIViewController {
    
    private let pdfName: String
    
    init(pdfName: String) {
        self.pdfName = pdfName
        super.init(nibName: nil, bundle: nil)
    }
    
    private let pdfView: PDFView = {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.backgroundColor = Resources.Colors.background
        return pdfView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupU()
        configureConstraints()
    }
    
    private func setupU() {
        view.backgroundColor = Resources.Colors.background
        view.addSubview(pdfView)
        configurePDF()
    }
    
    private func configureConstraints() {
        pdfView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func configurePDF() {
        guard let path = Bundle.main.url(forResource: pdfName, withExtension: "pdf") else { return }
        if let document = PDFDocument(url: path) {
            pdfView.document = document
        }
    }
}
