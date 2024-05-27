//
//  CalculatorViewController.swift
//  MyAITU
//
//  Created by Erik on 20.05.2024.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    private let midtermLabel: UILabel = {
        let label = UILabel()
        label.text = "Midterm Grade"
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var midtermTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter Your Midterm Grade",
            attributes: [NSAttributedString.Key.foregroundColor: Resources.Colors.secondaryGray]
        )
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.textColor = .white
        textField.backgroundColor = Resources.Colors.buttonBackground
        textField.keyboardType = .decimalPad
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    private let endtermLabel: UILabel = {
        let label = UILabel()
        label.text = "Endterm Grade"
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var endtermTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter Your Endterm Grade",
            attributes: [NSAttributedString.Key.foregroundColor: Resources.Colors.secondaryGray]
        )
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.textColor = .white
        textField.backgroundColor = Resources.Colors.buttonBackground
        textField.keyboardType = .twitter
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    private let gradeNeedToGetLabel: UILabel = {
        let label = UILabel()
        label.text = "Grade You Need To Get To:"
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let retakeLabel: UILabel = {
        let label = UILabel()
        let boldText = "Avoid a retake or FX (>50): "
        let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs1)

        let normalText = ""
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.white]
        let normalString = NSMutableAttributedString(string:normalText, attributes: attrs2)

        attributedString.append(normalString)
        label.attributedText = attributedString
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let scholarshipLabel: UILabel = {
        let label = UILabel()
        let boldText = "Save a Scholarship (>70): "
        let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs1)

        let normalText = ""
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.white]
        let normalString = NSMutableAttributedString(string:normalText, attributes: attrs2)

        attributedString.append(normalString)
        label.attributedText = attributedString
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let enhancedScholarshipLabel: UILabel = {
        let label = UILabel()
        let boldText = "Get an Enhanced Scholarship (>90): "
        let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs1)

        let normalText = ""
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.white]
        let normalString = NSMutableAttributedString(string:normalText, attributes: attrs2)

        attributedString.append(normalString)
        label.attributedText = attributedString
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let totalGradeLabel: UILabel = {
        let label = UILabel()
        let boldText = "If your final is 100%, your Total: "
        let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs1)

        let normalText = ""
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.white]
        let normalString = NSMutableAttributedString(string:normalText, attributes: attrs2)

        attributedString.append(normalString)
        label.attributedText = attributedString
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private lazy var calculateButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        let attributedTitle = NSAttributedString(
            string: "Calculate Scholarship",
            attributes: [
                .font: UIFont.systemFont(ofSize: 20, weight: .bold),
                .foregroundColor: UIColor.white
            ]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.configuration?.baseBackgroundColor = Resources.Colors.calculateButtonBackground
        button.configuration?.baseForegroundColor = .white
        button.configuration?.buttonSize = .large
        button.addTarget(self, action: #selector(calculateButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        endtermTextField.delegate = self
        setupUI()
        configureConstraints()
    }
    
    private func setupUI() {
        title = "Scholarship Calculator"
        view.backgroundColor = Resources.Colors.background
        view.addSubview(midtermTextField)
        view.addSubview(midtermLabel)
        view.addSubview(endtermLabel)
        view.addSubview(endtermTextField)
        view.addSubview(calculateButton)
        view.addSubview(gradeNeedToGetLabel)
        view.addSubview(retakeLabel)
        view.addSubview(scholarshipLabel)
        view.addSubview(enhancedScholarshipLabel)
        view.addSubview(totalGradeLabel)
    }
    
    private func configureConstraints() {
        midtermLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalToSuperview().offset(28)
        }
        
        midtermTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
            make.top.equalTo(midtermLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        endtermLabel.snp.makeConstraints { make in
            make.top.equalTo(midtermTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(28)
        }
        
        endtermTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
            make.top.equalTo(endtermLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        calculateButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
        
        gradeNeedToGetLabel.snp.makeConstraints { make in
            make.top.equalTo(endtermTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(28)
        }
        
        retakeLabel.snp.makeConstraints { make in
            make.top.equalTo(gradeNeedToGetLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(28)
        }
        
        scholarshipLabel.snp.makeConstraints { make in
            make.top.equalTo(retakeLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(28)
        }
        
        enhancedScholarshipLabel.snp.makeConstraints { make in
            make.top.equalTo(scholarshipLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(28)
        }
        
        totalGradeLabel.snp.makeConstraints { make in
            make.top.equalTo(enhancedScholarshipLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(28)
        }
    }
    
    override func viewDidLayoutSubviews() {
        midtermTextField.layer.masksToBounds = true
        midtermTextField.layer.cornerRadius = 12
        
        endtermTextField.layer.masksToBounds = true
        endtermTextField.layer.cornerRadius = 12
        
        calculateButton.layer.masksToBounds = true
        calculateButton.layer.cornerRadius = 12
    }
    
    // (midterm + endterm) / 2 = register term
    // (x - (register term * 0.6)) * 10 / 4
    
    private func calculateRetake(midterm: Double, endterm: Double) -> Double {
        let registerTerm = (midterm + endterm) / 2
        let totalCalculation = (50.0 - (registerTerm * 0.6)) * 10 / 4
        return totalCalculation
    }
    
    private func calculateSholarship(midterm: Double, endterm: Double) -> Double {
        let registerTerm = (midterm + endterm) / 2
        let totalCalculation = (70.0 - (registerTerm * 0.6)) * 10 / 4
        return totalCalculation
    }
    
    private func calculateEnhancedScholarship(midterm: Double, endterm: Double) -> Double {
        let registerTerm = (midterm + endterm) / 2
        let totalCalculation = (90.0 - (registerTerm * 0.6)) * 10 / 4
        return totalCalculation
    }
    
    private func calculateTotalGrade(midterm: Double, endterm: Double) -> Double {
        let registerTerm = (midterm + endterm) / 2 * 6 / 10 + 40
        return registerTerm
    }
    
    @objc private func calculateButtonTapped() {
        guard var midtermText = midtermTextField.text?.replacingOccurrences(of: ",", with: "."), !midtermText.isEmpty else {
            presentAlert(title: "Midterm grade is empty", message: "Please enter your midterm grade.")
            return
        }
        
        // Replace comma with period for decimal separator
        if let range = midtermText.range(of: ".") {
            midtermText = midtermText.replacingOccurrences(of: ",", with: "", options: [], range: range.lowerBound..<midtermText.endIndex)
        }
        
        guard let midterm = Double(midtermText) else {
            presentAlert(title: "Invalid midterm grade", message: "Please enter a valid numeric grade for the midterm.")
            return
        }
        
        guard var endtermText = endtermTextField.text?.replacingOccurrences(of: ",", with: "."), !endtermText.isEmpty else {
            presentAlert(title: "Endterm grade is empty", message: "Please enter your endterm grade.")
            return
        }
        
        // Replace comma with period for decimal separator
        if let range = endtermText.range(of: ".") {
            endtermText = endtermText.replacingOccurrences(of: ",", with: "", options: [], range: range.lowerBound..<endtermText.endIndex)
        }
        
        guard let endterm = Double(endtermText) else {
            presentAlert(title: "Invalid endterm grade", message: "Please enter a valid numeric grade for the endterm.")
            return
        }
    
        let retake = calculateRetake(midterm: midterm, endterm: endterm)
        let scholarship = calculateSholarship(midterm: midterm, endterm: endterm)
        let enhancedScholarship = calculateEnhancedScholarship(midterm: midterm, endterm: endterm)
        let totalGrade = calculateTotalGrade(midterm: midterm, endterm: endterm)
        
        if retake < 50 {
            retakeLabel.attributedText = attributedText(for: "Avoid a retake or FX (>50): ", value: "50.0")
        } else if retake >= 50 && retake <= 100 {
            retakeLabel.attributedText = attributedText(for: "Avoid a retake or FX (>50): ", value: String(retake))
        } else {
            retakeLabel.attributedText = attributedText(for: "Avoid a retake or FX (>50): ", value: "Impossible")
        }
        
        if scholarship < 50 {
            scholarshipLabel.attributedText = attributedText(for: "Save a Scholarship (>70): ", value: "50.0")
        } else if scholarship >= 50 && scholarship <= 100 {
            scholarshipLabel.attributedText = attributedText(for: "Save a Scholarship (>70): ", value: String(scholarship))
        } else {
            scholarshipLabel.attributedText = attributedText(for: "Save a Scholarship (>70): ", value: "Impossible")
        }
        
        if enhancedScholarship < 50 {
            enhancedScholarshipLabel.attributedText = attributedText(for: "Get an Enhanced Scholarship (>90): ", value: "50.0")
        } else if enhancedScholarship >= 50 && enhancedScholarship <= 100 {
            enhancedScholarshipLabel.attributedText = attributedText(for: "Get an Enhanced Scholarship (>90): ", value: String(enhancedScholarship))
        } else {
            enhancedScholarshipLabel.attributedText = attributedText(for: "Get an Enhanced Scholarship (>90): ", value: "Impossible")
        }
        
        if totalGrade >= 100 {
            totalGradeLabel.attributedText = attributedText(for: "If your final is 100%, your Total: ", value: "100.0")
        } else {
            totalGradeLabel.attributedText = attributedText(for: "If your final is 100%, your Total: ", value: String(totalGrade))
        }
        
    }
    
    private func attributedText(for prefix: String, value: String) -> NSAttributedString {
        let boldText = prefix
        let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedString = NSMutableAttributedString(string: boldText, attributes: attrs1)
        
        var normalText: String
        if let doubleValue = Double(value) {
            normalText = String(format: "%.1f%%", doubleValue)
        } else {
            normalText = value
        }
        
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.white]
        let normalString = NSMutableAttributedString(string: normalText, attributes: attrs2)
        
        attributedString.append(normalString)
        return attributedString
    }
}

extension CalculatorViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == endtermTextField {
            calculateButtonTapped()
        }
        return true
    }
}

