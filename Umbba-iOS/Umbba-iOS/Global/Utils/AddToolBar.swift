//
//  addToolBar.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/19.
//

import UIKit

extension UIView {
    
    func addToolbar(textfields: [CustomTextField]) {
        let toolBarKeyboard = UIToolbar()
        toolBarKeyboard.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btnDoneBar = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.dismissKeyBoard))
        toolBarKeyboard.items = [flexSpace, btnDoneBar]
        toolBarKeyboard.tintColor = UIColor.Primary600
        for (_, item) in textfields.enumerated() {
            item.inputAccessoryView = toolBarKeyboard
        }
    }
    
    func addToolBar(textView: UITextView) {
        let toolBarKeyboard = UIToolbar()
        toolBarKeyboard.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btnDoneBar = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.dismissKeyBoard))
        toolBarKeyboard.items = [flexSpace, btnDoneBar]
        toolBarKeyboard.tintColor = UIColor.Primary600
        textView.inputAccessoryView = toolBarKeyboard
    }
    
    @objc func dismissKeyBoard() {
        self.endEditing(true)
    }
    
    public func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        self.addGestureRecognizer(tap)
    }
}
