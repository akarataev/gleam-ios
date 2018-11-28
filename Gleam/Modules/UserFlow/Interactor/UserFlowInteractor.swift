//
//  UserFlowInteractor.swift
//  Gleam
//
//  Created by albert on 10/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation

// MARK: - UserFlowInteractorOutput
protocol UserFlowInteractorInput: class {
    func sendUserData(userData: UserFlowData)
}

// MARK: - UserFlowInteractorOutput
protocol UserFlowInteractorOutput: class {
    func didSuccessSendData()
    func didFailureSendData()
}

class UserFlowInteractor {
    weak var output: UserFlowInteractorOutput!
}

extension UserFlowInteractor: UserFlowInteractorInput {
    func sendUserData(userData: UserFlowData) {
        NetworkManager.sendUserData(userData: userData) { [weak self] result in
            switch result {
            case .success:
                self?.output.didSuccessSendData()
            case .failure:
                self?.output.didFailureSendData()
            }
        }
    }
}
