//
//  CancelViewController.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/13.
//

import UIKit

class WithdrawalViewController: UIViewController {
    
    private let withdrawalView = WithdrawalView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        view = withdrawalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
    }
}

// MARK: - Extensions

private extension WithdrawalViewController {
    
    func setDelegate() {
        withdrawalView.navigationdelegate = self
    }
}

extension WithdrawalViewController: NavigationBarDelegate {
    
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {
    }
    
}
