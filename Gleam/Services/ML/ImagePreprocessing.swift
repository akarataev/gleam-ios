//
//  ImagePreprocessing.swift
//  Gleam
//
//  Created by Каратаев Алексей on 10.11.2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import UIKit

// MARK: - implement image preprocessing for VGG16 model

extension CIImage {
    
    var preprocess: CGImage?  {
        return self.convertToBrg().resizeWith (
            size: CGSize (width: 256, height: 256))
            .cgImage
    }
}


// MARK: - implement swap RGB to BRG system

private extension CIImage {
    
    var brgColorKernel: CIColorKernel? {
        return CIColorKernel(source:
            "kernel vec4 swapRedAndGreenAmount(__sample s) {" +
                "return s.rbga;" +
            "}"
        )
    }
    
    func convertToBrg() -> UIImage {
        let ciOutput = brgColorKernel?.apply(extent: self.extent, arguments: [self as Any])
        return UIImage(cgImage: CIContext().createCGImage(ciOutput!, from: self.extent)!)
    }
}


// MARK: - implement resize image for VGG16 model

fileprivate extension UIImage {
    
    func resizeWith(size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: size))
        }
    }
}
