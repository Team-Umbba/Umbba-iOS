//
//  String+.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/04.
//

import UIKit

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isContainEnglish() -> Bool {
        let pattern = "[A-Za-z]+"
        guard self.range(of: pattern, options: .regularExpression) != nil else { return false}
        return true
    }
    
    func isContainNumber() -> Bool {
        let pattern = ".*[0-9]+.*"
        guard self.range(of: pattern, options: .regularExpression) != nil else { return false}
        return true
    }
    
    func isContainNumberAndAlphabet() -> Bool {
        let pattern = "^[0-9a-zA-Z]*$"
        guard self.range(of: pattern, options: .regularExpression) != nil else { return false}
        return true
    }
    
    func isOnlyKorean() -> Bool {
        let pattern = "^[가-힣]*$"
        guard self.range(of: pattern, options: .regularExpression) != nil else { return false }
        return true
    }
    
    func isValidInviteCode() -> Bool {
        let pattern = "^[A-Z]{4}-[a-zA-Z0-9]{6}$"
        guard self.range(of: pattern, options: .regularExpression) != nil else { return false }
        return true
    }
}
