//
//  StringExtension.swift
//  Notes
//
//  Created by Tobias Ruano on 07/07/2021.
//

import Foundation

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailAdd = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailAdd.evaluate(with: self)
    }
    
}
