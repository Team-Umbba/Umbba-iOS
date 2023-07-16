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
    
    func makeAlert(writePopUp: WritePopUp,
                   alertType: AlertType = .writeSaveAlert,
                   okAction: (() -> Void)?) {
        
        let alertViewController = AlertViewController()
        
        alertViewController.setAlertType(alertType)
        alertViewController.setDataBind(wirtePopUp: writePopUp)
        alertViewController.okAction = okAction
        alertViewController.modalTransitionStyle = .crossDissolve
        alertViewController.modalPresentationStyle = .overCurrentContext
        present(alertViewController, animated: true)
    }
    
    func makeAlert(inviteCode: String, inviteUsername: String, installURL: String,
                   alertType: AlertType = .inviteAlert,
                   okAction: (() -> Void)?) {
        
        let alertViewController = AlertViewController()
        
        alertViewController.setAlertType(alertType)
        alertViewController.setInviteDataBind(inviteCode: inviteCode, inviteUsername: inviteUsername, installURL: installURL)
        alertViewController.okAction = okAction
        alertViewController.modalTransitionStyle = .crossDissolve
        alertViewController.modalPresentationStyle = .overCurrentContext
        present(alertViewController, animated: true)
    }
}
