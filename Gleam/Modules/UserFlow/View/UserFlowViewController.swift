//
//  UserFlowViewController.swift
//  Gleam
//
//  Created by albert on 10/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class UserFlowViewController: UIViewController {
    
    private lazy var titleLabel = self.createTitleLabel()
    private lazy var textField = self.createTextField()
    private lazy var placeholdeLabel = self.createPlaceholderLabel()
    private lazy var nextButton = self.createNextButton()
    private lazy var borderBottomBiew = self.createBottomBorderView()
    
    var userData = UserData()
    var currentState: UserFormState = .name
    
    private var textFieldValue = "" {
        didSet {
            changeButtonState()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        textFieldValue = ""
        setupKeyboard()
        titleLabel.text = currentState.getTitle()
        textField.placeholder = currentState.getPlaceholder()
        _ = textField
        _ = nextButton
        _ = borderBottomBiew
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        textField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textField.resignFirstResponder()
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        navigationController?.navigationBar.barTintColor = UIColor.HealthColors.neonBlue
    }
    
    @objc func changeFrame(_ sender: Notification) {
        guard let height = (sender.userInfo!["UIKeyboardBoundsUserInfoKey"] as? CGRect)?.height else { return }
        nextButton.snp.remakeConstraints { make in
            make.height.equalTo(57)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-height)
        }
    }
    
    @objc func tapButton() {
        let dataVC = UserDataViewController()
        switch currentState {
        case .name:
            userData.name = textFieldValue
            dataVC.currentState = .number
        case .number:
            userData.number = textFieldValue
            dataVC.currentState = .email
        case .email:
            userData.email = textFieldValue
            showSuccessAlert()
            
        }
        dataVC.userData = userData
        navigationController?.pushViewController(dataVC, animated: true)
    }
    
    @objc func changeTextField(_ sender: UITextField) {
        let placeholderHidden = sender.text?.isEmpty ?? true
        showPlaceholder(placeholderHidden)
        textFieldValue = sender.text ?? ""
    }
    
    func showSuccessAlert() {
        let alertVC = UIAlertController(title: "GOTOVO", message: "TI SKORO UMREW", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            if let stack = self.navigationController?.viewControllers.filter({ !($0 is UserDataViewController) }) {
                self.navigationController?.setViewControllers(stack, animated: true)
            }
        }))
        present(alertVC, animated: true)
    }
}

// MARK: - UI creation methods
private extension UserFlowViewController {
    
    func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.textColor = .black
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.left.equalToSuperview().offset(14)
        }
        return label
    }
    
    func createTextField() -> UITextField {
        let textField = UITextField()
        textField.textColor = UIColor.black
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.addTarget(self, action: #selector(changeTextField), for: .editingChanged)
        textField.keyboardType = .namePhonePad
        textField.autocorrectionType = .no
        view.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(53)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(18)
        }
        return textField
    }
    
    func createPlaceholderLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Your name"
        label.textColor = UIColor.HealthColors.veryLightPinkTwo
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.bottom.equalTo(textField.snp.top).offset(-8)
            make.leading.equalTo(textField).offset(0)
        }
        
        return label
    }
    
    func createNextButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Next step", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(UIColor.HealthColors.veryLightPinkTwo, for: .disabled)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.height.equalTo(57)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
        }
        return button
    }
    
    func createBottomBorderView() -> UIView {
        let borderView = UIView()
        borderView.backgroundColor = UIColor.HealthColors.neonBlue
        view.addSubview(borderView)
        
        borderView.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.top.equalTo(textField.snp.bottom).offset(8)
        }
        return borderView
    }
}

// MARK: - Private methods
extension UserFlowViewController {
    
    func changeButtonState() {
        if textFieldValue.isEmpty {
            nextButton.backgroundColor = .white
            nextButton.isEnabled = false
        } else {
            nextButton.backgroundColor = UIColor.HealthColors.neonBlue
            nextButton.isEnabled = true
        }
    }
    
    func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }
    
    func showPlaceholder(_ show: Bool) {
        placeholdeLabel.isHidden = show
    }
}

extension UserFlowViewController: GleamNavigationControllerStylable { }
