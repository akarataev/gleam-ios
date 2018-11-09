//
//  GleamNavigationControllerStylable.swift
//  Gleam
//
//  Created by albert on 09/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import UIKit

protocol GleamNavigationControllerStylable {
    func setupNavigationBarForClinicListViewController()
}

extension GleamNavigationControllerStylable where Self: UIViewController {
    
    func setupNavigationBarForClinicListViewController() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor.Gleam.neonBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.layer.backgroundColor = UIColor.Gleam.neonBlue.cgColor
    }
}
