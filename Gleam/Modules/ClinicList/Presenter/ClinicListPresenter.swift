//
//  ClinicListPresenter.swift
//  Gleam
//
//  Created by albert on 09/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//


import Foundation
import UIKit

// MARK: - ClinicListPresenter

class ClinicListPresenter {
    
    weak var view: ClinicListViewControllerInput?
    var interactor: ClinicListInteractorInput
    
    private var clinics = [ClinicModel]()
    private var filteredClinics = [ClinicModel]()
    private let locationManager = LocationManager()
    
    init(interactor: ClinicListInteractorInput) {
        self.interactor = interactor
        locationManager.delegate = self
    }
}

extension ClinicListPresenter: LocationManagerDelegate {
    
    func locationManagerDidChangeRequestStatus(_ locationManager: LocationManager, enable: Bool) {
        if !enable {
            interactor.loadClinics()
        }
    }
    
    func locationManagerDidChangeCoordinates(_ locationManager: LocationManager) {
        interactor.loadClinics()
    }
}

// MARK: - ClinicListViewControllerOutput
extension ClinicListPresenter: ClinicListViewControllerOutput {
    
    func clinicListViewControllerDidLoad(_ view: ClinicListViewController) {
        locationManager.requestAccess()
    }
    
    func clinicListViewControllerGetRows(_ view: ClinicListViewController) -> Int {
        return filteredClinics.count
    }
    
    func clinicListViewControllerGetCell(_ view: ClinicListViewController, tableView: UITableView, indexPath: IndexPath) -> ClinicTableViewCell {
        guard let clinicCell = tableView.dequeueReusableCell(withIdentifier: "ClinicTableViewCell", for: indexPath) as? ClinicTableViewCell else {
            fatalError("Error converting cell")
        }
        let model = filteredClinics[indexPath.row]
        clinicCell.setup(with: model)
        return clinicCell
    }
    
    func clinicListViewControllerLoadWithFilter(_ view: ClinicListViewController, text: String) {
        if text.isEmpty {
            filteredClinics = clinics
        } else {
            filteredClinics = clinics.filter { $0.title.contains(text) }
        }
        view.renderClinics()
    }
    
    func clinicListViewControllerDidSelectedClinic(_ view: ClinicListViewController, indexPath: IndexPath) {
        let userData = UserFlowData()
        userData.clinicId = filteredClinics[indexPath.row].clinicId
        view.navigateToUserFlow(userData: userData)
    }
}

// MARK: - ClinicListInteractorOutput
extension ClinicListPresenter: ClinicListInteractorOutput {
    
    func didLoadClinicsSuccess(_ clinics: [ClinicModel]) {
        self.clinics = clinics
        self.filteredClinics = clinics
        view?.renderClinics()
    }
    
    func didLoadClinicsFailure(_ error: GleamError) {
        view?.renderError(description: error.localizedDescription)
    }
}
