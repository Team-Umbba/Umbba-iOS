//
//  CancelViewController.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/13.
//

import UIKit

class CancelViewController: UIViewController {
    
    private let cancelView = CancelView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        view = cancelView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
    }
}

// MARK: - Extensions

private extension CancelViewController {
    
    func setDelegate() {
        cancelView.navigationdelegate = self
    }
}

extension CancelViewController: NavigationBarDelegate {
    
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {
    }
    
}
