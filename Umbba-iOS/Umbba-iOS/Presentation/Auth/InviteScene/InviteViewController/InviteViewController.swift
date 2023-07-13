//
//  InviteViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/04.
//

import UIKit

import SnapKit

final class InviteViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let inviteView = InviteView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = inviteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        inviteView.registerForKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        inviteView.unregisterForKeyboardNotifications()
    }
}

// MARK: - Extensions

extension InviteViewController {
    func setDelegate() {
        inviteView.navigationdelegate = self
        inviteView.nextDelegate = self
    }
}

extension InviteViewController: NavigationBarDelegate {
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {
        
    }
}

extension InviteViewController: NextButtonDelegate {
    func nextButtonTapped() {
        let userInfoViewController =  UserInfoViewController()
        self.navigationController?.pushViewController(userInfoViewController, animated: true)
        userInfoViewController.isReciever = true
    }
}
