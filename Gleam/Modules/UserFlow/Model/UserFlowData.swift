//
//  UserFlowData.swift
//  Gleam
//
//  Created by albert on 10/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation

class UserFlowData {
    var name = ""
    var number = ""
    var email = ""
    
    func validatedPhoneNumber() -> Bool {
        let phoneRegex = "\\A[0-9]{11}\\z"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let result = phoneTest.evaluate(with: number)
        return result
    }
    
    func validaEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }
}
