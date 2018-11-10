//
//  SkinCancerClassificatorDelegate.swift
//  Gleam
//
//  Created by Каратаев Алексей on 10.11.2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import Vision

// MARK: - implement own delegate for VGG16 model

protocol SkinCancerClassificatorDelegate {
    
    func classificatorFinishedWith(stats: Array<(String, Float)>)
    
}
