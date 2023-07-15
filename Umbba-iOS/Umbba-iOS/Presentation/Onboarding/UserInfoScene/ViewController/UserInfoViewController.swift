//
//  UserInfoViewController.swift
//  Umbba-Lab
//
//  Created by 최영린 on 2023/07/06.
//

import UIKit

final class UserInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    var isReceiver: Bool = false
    
    // MARK: - UI Components
    
    private let inviteViewController = InviteViewController()
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
        if isReceiver {
            let questViewController =  QuestViewController()
            self.navigationController?.pushViewController(questViewController, animated: true)
            questViewController.isReceiver = true
        } else {
            self.navigationController?.pushViewController(FamilyInfoViewController(), animated: true)
        }
    }
}
