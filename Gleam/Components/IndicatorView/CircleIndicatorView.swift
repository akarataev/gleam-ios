//
//  CircleIndicatorView.swift
//  Gleam
//
//  Created by Каратаев Алексей on 09.11.2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import UIKit

class CircleIndicatorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = frame.size.width / 2
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


// MARK: - implement retrun CircleIndicatorView with regular size

extension CircleIndicatorView {
    
    static func getCircle(size: CGFloat) -> CircleIndicatorView {
        return CircleIndicatorView (
            frame: CGRect (
                origin: .zero,
                size: CGSize(width: size, height: size)
            )
        )
    }
    
    static var regular: CircleIndicatorView {
        return getCircle(size: 16)
    }
}


// MARK: - implement return CircleIndicatorView as buttonView

extension CircleIndicatorView {
    
    static var buttonView: CircleIndicatorView {
        let base = getCircle(size: 88)
        let spot = getCircle(size: 56)
        
        base.addSubview(spot)
        base.apply (.baseButtonViewStyle)
        
        spot.apply (
            .spotButtonViewStyle,
            .spotButtonViewLayoutStyle(at: base)
        )
        
        return base
    }
}

