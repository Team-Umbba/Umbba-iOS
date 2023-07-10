//
//  WriteCancelAlertVIewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/11.
//

import UIKit

enum AlertType {
    case writeCancelAlert
    case writeSaveAlert
    case withdrawalAlert
}

final class AlertViewController: UIViewController {
    
    // MARK: - Properties
    
    var alertType: AlertType = .writeCancelAlert
    var okAction: (() -> Void)?
    
    // MARK: - UI Components
    
    private let writeCancelAlertView: WriteCancelAlertView = {
        let view = WriteCancelAlertView()
        return view
    }()
    
    private let writeSaveAlertView: WriteSaveWriteView = {
        let view = WriteSaveWriteView()
        return view
    }()
    
    private let withdrawalAlertView: WithdrawalAlertView = {
        let view = WithdrawalAlertView()
        return view
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setAlertType()
        setLayout()
        setDelegate()
    }
}

// MARK: - Extensions

private extension AlertViewController {
    
    func setUI() {
        view.backgroundColor = .black.withAlphaComponent(0.4)
    }
    
    func setAlertType() {
        switch alertType {
        case .writeCancelAlert:
            setAlertView(writeCancel: true, writeSave: false, withdrawal: false)
        case .writeSaveAlert:
            setAlertView(writeCancel: false, writeSave: true, withdrawal: false)
        case .withdrawalAlert:
            setAlertView(writeCancel: false, writeSave: false, withdrawal: true)
        }
    }
    
    private func setAlertView(writeCancel: Bool, writeSave: Bool, withdrawal: Bool) {
        writeCancelAlertView.isHidden = !writeCancel
        writeSaveAlertView.isHidden = !writeSave
        withdrawalAlertView.isHidden = !withdrawal
    }

    private func setLayout() {
        view.addSubviews(writeCancelAlertView,
                         writeSaveAlertView,
                         withdrawalAlertView)
        
        writeCancelAlertView.snp.makeConstraints {
            let writeCancelWidth = SizeLiterals.Screen.screenWidth * 343 / 375
            $0.center.equalToSuperview()
            $0.width.equalTo(writeCancelWidth)
            $0.height.equalTo(writeCancelWidth * 164 / 343)
        }
        
        writeSaveAlertView.snp.makeConstraints {
            let writeSaveAlertWidth = SizeLiterals.Screen.screenWidth * 343 / 375
            $0.center.equalToSuperview()
            $0.width.equalTo(writeSaveAlertWidth)
        }
        
        withdrawalAlertView.snp.makeConstraints {
            let withdrawalWidth = SizeLiterals.Screen.screenWidth * 343 / 375
            $0.center.equalToSuperview()
            $0.width.equalTo(withdrawalWidth)
            $0.height.equalTo(withdrawalWidth * 164 / 343)
        }
    }
    
    private func setDelegate() {
        writeCancelAlertView.delegate = self
        writeSaveAlertView.delegate = self
        withdrawalAlertView.delegate = self
    }
    
    private func emptyActions() {
        
    }
}

// MARK: - AlertDelegate

extension AlertViewController: AlertDelegate {
    
    func cancelButtonTapped() {
        dismiss(animated: false) {
            (self.okAction ?? self.emptyActions)()
        }
    }

    func confirmButtonTapped() {
        dismiss(animated: true)
    }
}
