//
//  UserFlowPresenter.swift
//  Gleam
//
//  Created by albert on 10/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UserFlowPresenter
class UserFlowPresenter {
    
    weak var view: UserFlowViewControllerInput?
    private var currentState: UserFormState
    private var userData = UserFlowData()
    private var interactor: UserFlowInteractorInput
    
    init(interactor: UserFlowInteractorInput, currentState: UserFormState, userData: UserFlowData) {
        self.interactor = interactor
        self.currentState = currentState
        self.userData = userData
    }
    
    // swiftlint:disable:next function_body_length
    private func prepareForRender() {
        var placeholderHidden = true
        var buttonEnable = false
        var currentText = ""
        var keyboardType: UIKeyboardType
        switch currentState {
        case .name:
            keyboardType = .namePhonePad
            currentText = userData.name.trimmingCharacters(in: CharacterSet(charactersIn: " "))
            if currentText.isEmpty {
                placeholderHidden = true
                buttonEnable = false
            } else if currentText.count < 2 {
                placeholderHidden = false
            } else {
                placeholderHidden = false
                buttonEnable = true
            }
        case .number:
            keyboardType = .phonePad
            currentText = userData.number
            if currentText.isEmpty {
                placeholderHidden = true
                buttonEnable = false
            } else if !userData.validatedPhoneNumber() {
                placeholderHidden = false
            } else {
                placeholderHidden = false
                buttonEnable = true
            }
        case .email:
            keyboardType = .emailAddress
            currentText = userData.email.trimmingCharacters(in: CharacterSet(charactersIn: " "))
            if currentText.isEmpty {
                placeholderHidden = true
                buttonEnable = false
            } else if !userData.validaEmail() {
                placeholderHidden = false
            } else {
                placeholderHidden = false
                buttonEnable = true
            }
        }
        let buttonColor = buttonEnable ? UIColor.Gleam.neonBlue : .white
        let viewState = UserFlowViewState(title: currentState.getTitle(),
                                          placeholder: currentState.getPlaceholder(),
                                          placeholderHidden: placeholderHidden,
                                          buttonEnable: buttonEnable,
                                          buttonColor: buttonColor,
                                          textFieldValue: currentText,
                                          keyboardType: keyboardType)
        self.view?.render(viewState: viewState)
    }
    
    func userFlowViewControllerNavigate(_ view: UserFlowViewController) {
        switch currentState {
        case .name:
            let nextVC = UserFlowConfigurator.configure(currentState: .number, userData: userData)
            view.navigationController?.pushViewController(nextVC, animated: true)
        case .number:
            let nextVC = UserFlowConfigurator.configure(currentState: .email, userData: userData)
            view.navigationController?.pushViewController(nextVC, animated: true)
        case .email:
            interactor.sendUserData(userData: userData)
        }
    }
}

// MARK: - UserFlowViewControllerOutput
extension UserFlowPresenter: UserFlowViewControllerOutput {
    
    func userFlowViewControllerDidLoad(_ view: UserFlowViewController) {
        prepareForRender()
    }
    
    func userFlowViewControllerTextFieldChanged(_ view: UserFlowViewController, text: String?) {
        switch currentState {
        case .name:
            userData.name = text ?? ""
        case .number:
            userData.number = text ?? ""
        case .email:
            userData.email = text ?? ""
        }
        prepareForRender()
    }
    
    var currentUserData: UserFlowData {
        return userData
    }
    
    var currentFormState: UserFormState {
        return currentState
    }
    
    func userFlowViewControllerSendUserData(_ view: UserFlowViewController) {
        interactor.sendUserData(userData: userData)
    }
}

extension UserFlowPresenter: UserFlowInteractorOutput {
    
    func didSuccessSendData() {
        view?.successSendData()
    }
    
    func didFailureSendData() {
        view?.failureSendData()
    }
}
