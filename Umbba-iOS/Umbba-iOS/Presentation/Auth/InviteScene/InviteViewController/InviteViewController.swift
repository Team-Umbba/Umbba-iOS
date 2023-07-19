//
//  InviteViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/04.
//

import UIKit

import SnapKit

final class InviteViewController: UIViewController {
    
    // MARK: - Properties
    
    var isReceiver: Bool = false
    
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
        guard let inviteCode = inviteView.inviteTextField.text else { return }
        patchMatchAPI(inviteCode: inviteCode)
    }
}

extension InviteViewController {
    func patchMatchAPI(inviteCode: String) {
        OnBoardingService.shared.postMatchAPI(invite_code: inviteCode) { networkResult in
            print(networkResult)
            switch networkResult {
            case .success:
                let animationViewController =  AnimationViewController()
                self.navigationController?.pushViewController(animationViewController, animated: true)
                animationViewController.isReceiver = true
            case .requestErr:
                self.inviteView.inviteTextField.textFieldStatus = .uncorrectedType
                self.inviteView.errorLabel.isHidden = false
                self.inviteView.errorLabel.text = "유효하지 않은 초대코드입니다."
            default:
                break
            }
        }
    }
}
