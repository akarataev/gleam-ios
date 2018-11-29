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

// MARK: - UserFlowViewControllerInput
protocol UserFlowViewControllerInput: class {
    func render(viewState: UserFlowViewState)
    func successSendData()
    func failureSendData()
}

// MARK: UserFlowViewControllerOutput
protocol UserFlowViewControllerOutput: class {
    func userFlowViewControllerDidLoad(_ view: UserFlowViewController)
    func userFlowViewControllerTextFieldChanged(_ view: UserFlowViewController, text: String?)
    func userFlowViewControllerSendUserData(_ view: UserFlowViewController)
    func userFlowViewControllerNavigate(_ view: UserFlowViewController)
    
    var currentUserData: UserFlowData { get }
    var currentFormState: UserFormState { get }
}

// MARK: - UserFlowViewController
class UserFlowViewController: UIViewController {
    
    private lazy var titleLabel = self.createTitleLabel()
    private lazy var textField = self.createTextField()
    private lazy var placeholdeLabel = self.createPlaceholderLabel()
    private lazy var nextButton = self.createNextButton()
    private lazy var borderBottomBiew = self.createBottomBorderView()
    
    var output: UserFlowViewControllerOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        output.userFlowViewControllerDidLoad(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBarForUserFlowViewController()
        textField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textField.resignFirstResponder()
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        guard let navigationController = navigationController else { return }
        let countUserFlowVC = navigationController.viewControllers.filter { $0 is UserFlowViewController }.count
        if countUserFlowVC == 1 {
            navigationController.navigationBar.barTintColor = UIColor.Gleam.neonBlue
        }
    }
}

// MARK: - User actions
extension UserFlowViewController {
    
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
        output.userFlowViewControllerNavigate(self)
    }
    
    @objc func changeTextField(_ sender: UITextField) {
        output.userFlowViewControllerTextFieldChanged(self, text: sender.text)
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
        label.textColor = UIColor.Gleam.veryLightPinkTwo
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
        button.setTitleColor(UIColor.Gleam.veryLightPinkTwo, for: .disabled)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.height.equalTo(57)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        return button
    }
    
    func createBottomBorderView() -> UIView {
        let borderView = UIView()
        borderView.backgroundColor = UIColor.Gleam.neonBlue
        view.addSubview(borderView)
        
        borderView.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(textField.snp.bottom).offset(8)
        }
        return borderView
    }
}

// MARK: - Private methods
private extension UserFlowViewController {
    
    func setupView() {
        view.backgroundColor = .white
        setupKeyboard()
        _ = borderBottomBiew
    }
    
    func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
}

// MARK: - UserFlowViewControllerInput
extension UserFlowViewController: UserFlowViewControllerInput {
    
    func render(viewState: UserFlowViewState) {
        titleLabel.text = viewState.title
        textField.placeholder = viewState.placeholder
        textField.text = viewState.textFieldValue
        placeholdeLabel.text = viewState.title
        placeholdeLabel.isHidden = viewState.placeholderHidden
        nextButton.isEnabled = viewState.buttonEnable
        nextButton.backgroundColor = viewState.buttonColor
        textField.keyboardType = viewState.keyboardType
        nextButton.setTitle(viewState.buttonTitle, for: .normal)
    }
    
    func successSendData() {
        goBack(success: true)
    }
    
    func failureSendData() {
        goBack(success: false)
    }
    
    func goBack(success: Bool) {
        guard let stack = self.navigationController?.viewControllers.filter({ !($0 is UserFlowViewController) }),
            let clinicListVC = stack.last as? ClinicListViewController else {
            return
        }
        navigationController?.setViewControllers(stack, animated: true)
        clinicListVC.showAlert(success: success)
    }
}

// MARK: - GleamNavigationControllerStylable
extension UserFlowViewController: GleamNavigationControllerStylable { }
