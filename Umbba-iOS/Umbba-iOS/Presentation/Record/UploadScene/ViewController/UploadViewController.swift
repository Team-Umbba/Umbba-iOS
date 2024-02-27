//
//  UploadViewController.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2/27/24.
//

import UIKit

final class UploadViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let uploadView = UploadView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = uploadView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
    }
}

// MARK: - Extensions

extension UploadViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setDelegate() {
        uploadView.navigationdelegate = self
    }
}

extension UploadViewController: NavigationBarDelegate {
    
    @objc
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {
    }
    
}
