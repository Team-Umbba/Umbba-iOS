//
//  ShowToast.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/15.
//

import UIKit

import SnapKit

extension UIViewController {
    func showToast(message: String) {
        Toast.show(message: message, controller: self)
    }
}

final class Toast {
    static func show(message: String, controller: UIViewController) {
        
        let toastContainer = UIView()
        let toastLabel = UILabel()
        
        toastContainer.backgroundColor = .White500
        toastContainer.alpha = 1
        toastContainer.layer.cornerRadius = 5
        toastContainer.clipsToBounds = true
        toastContainer.isUserInteractionEnabled = false
        
        toastLabel.textColor = .UmbbaBlack
        toastLabel.textAlignment = .center
        toastLabel.font = .PretendardSemiBold(size: 13)
        toastLabel.text = message
        toastLabel.clipsToBounds = true
        toastLabel.numberOfLines = 0
        toastLabel.sizeToFit()
        
        toastContainer.addSubview(toastLabel)
        controller.view.addSubview(toastContainer)
        
        toastContainer.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(controller.view.safeAreaLayoutGuide).inset(56)
            $0.width.equalTo(toastLabel.frame.width + 40)
            $0.height.equalTo(toastLabel.frame.height + 20)
        }
        
        toastLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.4, delay: 1.0, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }, completion: {_ in
                toastContainer.removeFromSuperview()
            })
        })
    }
}
