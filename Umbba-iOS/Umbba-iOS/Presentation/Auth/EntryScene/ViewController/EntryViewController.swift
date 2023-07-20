//
//  EntryViewController.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/05.
//

import UIKit

final class EntryViewController: UIViewController {

    private let entryView = EntryView()
    
    override func loadView() {
        super.loadView()
        
        self.view = entryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
    }

}

// MARK: - Extensions

extension EntryViewController {
    func setDelegate() {
        entryView.entryDelegate = self
    }
}

extension EntryViewController: EntryDelegate {
    func entryButtonTapped() {
        self.navigationController?.pushViewController(AnimationViewController(), animated: true)
    }
    
    func inviteButtonTapped() {
        let inviteViewController = InviteViewController()
        inviteViewController.isReceiver = true
        
        if UserManager.shared.getIsMatch {
            let animationViewController =  AnimationViewController()
            self.navigationController?.pushViewController(animationViewController, animated: true)
            animationViewController.isReceiver = true
        } else {
            self.navigationController?.pushViewController(inviteViewController, animated: true)
        }
    }
}
