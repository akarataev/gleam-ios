//
//  Styles.swift
//  Gleam
//
//  Created by Каратаев Алексей on 09.11.2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation

// MARK :- implement style type

typealias Style<Element> = (Element) -> Void
enum StyleWrapper<Element> { case wrap(style: Style<Element>) }


// MARK :- stylable protocol declaration

protocol Stylable {}
extension NSObject: Stylable {}


// MARK :- stylable default implementation

extension Stylable {
    
    static func style(style: @escaping Style<Self>) -> Style<Self> { return style }
    
    func apply(_ styles: StyleWrapper<Self>...) {
        styles.forEach { switch $0 { case let .wrap(style): style(self) } }
    }
}
