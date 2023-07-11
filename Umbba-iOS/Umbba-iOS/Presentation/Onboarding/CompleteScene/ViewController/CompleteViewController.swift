//
//  CompleteViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/09.
//

import UIKit

final class CompleteViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let completeView = CompleteView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = completeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
    }
}

// MARK: - Extensions

private extension CompleteViewController {

    func setDelegate() {
        completeView.navigationdelegate = self
        completeView.nextDelegate = self
    }
}

extension CompleteViewController: NavigationBarDelegate {
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {

    }
}

extension CompleteViewController: NextButtonDelegate {
    func nextButtonTapped() {
        // FixMe: - Main화면으로 이동
        self.navigationController?.pushViewController(CompleteViewController(), animated: true)
    }
}
