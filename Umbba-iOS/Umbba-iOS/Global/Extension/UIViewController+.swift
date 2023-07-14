//
//  UIViewController+.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/03.
//

import UIKit

extension UIViewController {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func makeAlert(alertType: AlertType = .writeCancelAlert,
                   okAction: (() -> Void)?) {
        
        let alertViewController = AlertViewController()
        
        alertViewController.alertType = alertType
        alertViewController.okAction = okAction
        alertViewController.modalTransitionStyle = .crossDissolve
        alertViewController.modalPresentationStyle = .overCurrentContext
        present(alertViewController, animated: true)
    }
    
    func makeAlert(answerWrite: AnswerWrite,
                   alertType: AlertType = .writeSaveAlert,
                   okAction: (() -> Void)?) {
        
        let alertViewController = AlertViewController()
        
        alertViewController.setAlertType(alertType)
        alertViewController.setDataBind(answerWrite: answerWrite)
        alertViewController.okAction = okAction
        alertViewController.modalTransitionStyle = .crossDissolve
        alertViewController.modalPresentationStyle = .overCurrentContext
        present(alertViewController, animated: true)
    }
}
