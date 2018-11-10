//
//  ScreeningScreeningRouterInput.swift
//  Gleam
//
//  Created by Каратаев Алексей on 09/11/2018.
//  Copyright © 2018 Apptolab. All rights reserved.
//

import UIKit
import Foundation

@objc protocol ScreeningRouterInput {
    func passData(segue: UIStoryboardSegue)
    func toClinicScreen(sender: UIViewController)
}
