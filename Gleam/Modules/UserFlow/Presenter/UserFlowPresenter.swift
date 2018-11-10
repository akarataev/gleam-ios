//
//  UserFlowPresenter.swift
//  Gleam
//
//  Created by albert on 10/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import UIKit

class UserFlowPresenter {
    
    weak var view: UserFlowViewControllerInput?
    private var currentState: UserFormState = .name
    private var userData = UserData()
}

extension UserFlowPresenter: UserFlowViewControllerOutput {
    
    func userFlowViewControllerDidLoad(_ view: UserFlowViewController) {
        self.view?.render(title: currentState.getTitle(), placeholder: currentState.getPlaceholder())
    }
}
