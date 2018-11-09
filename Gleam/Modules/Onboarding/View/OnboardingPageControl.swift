//
//  OnboardingPageControl.swift
//  Gleam
//
//  Created by albert on 09/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import UIKit

class OnboardingPageControl: UIPageControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        currentPage = 0
        numberOfPages = 3
        pageIndicatorTintColor = UIColor.Gleam.veryLightPink
        currentPageIndicatorTintColor = UIColor.Gleam.neonBlue
    }
}
