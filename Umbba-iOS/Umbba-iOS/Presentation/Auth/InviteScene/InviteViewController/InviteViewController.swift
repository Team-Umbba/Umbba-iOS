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
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        view = inviteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationUI()
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

// MARK: - Methods

extension InviteViewController {
    func setNavigationUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .UmbbaBlack
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.PretendardRegular(size: 16), .foregroundColor: UIColor.UmbbaBlack]
        navigationItem.title = I18N.Onboarding.inviteNavigationTitle
    }
    
    @objc
    func backButtonTapped() {
        print("이전 화면으로 이동")
    }
}
