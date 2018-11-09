//
//  ClinicListInteractor.swift
//  Gleam
//
//  Created by albert on 09/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation

// MARK: - ClinicListInteractorInput
protocol ClinicListInteractorInput: class {
    func loadClinics()
}

// MARK: - ClinicListInteractorOutput
protocol ClinicListInteractorOutput: class {
    func didLoadClinicsSuccess(_ clinics: [ClinicModel])
    func didLoadClinicsFailure(_ error: GleamError)
}

// MARK: - ClinicListInteractor
class ClinicListInteractor {
    weak var output: ClinicListInteractorOutput?
}

// MARK: - ClinicListInteractorInput
extension ClinicListInteractor: ClinicListInteractorInput {
    func loadClinics() {
        NetworkManager.getClinics { [weak self] value in
            switch value {
            case .success(let clinics):
                self?.output?.didLoadClinicsSuccess(clinics)
            case .failure(let error):
                self?.output?.didLoadClinicsFailure(error)
            }
        }
    }
}
