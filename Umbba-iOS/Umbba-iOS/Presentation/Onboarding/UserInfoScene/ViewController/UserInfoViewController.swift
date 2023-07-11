//
//  UserInfoViewController.swift
//  Umbba-Lab
//
//  Created by 최영린 on 2023/07/06.
//

import UIKit

final class UserInfoViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let userInfoView = UserInfoView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = userInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
    }
}

// MARK: - Extensions

extension UserInfoViewController {
    func setDelegate() {
        userInfoView.navigationdelegate = self
        userInfoView.nextDelegate = self
    }
}

extension UserInfoViewController: NavigationBarDelegate {
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {
        
    }
}

extension UserInfoViewController: NextButtonDelegate {
    func nextButtonTapped() {
        self.navigationController?.pushViewController(FamilyInfoViewController(), animated: true)
    }
}
