//
//  CancelViewController.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/13.
//

import UIKit

class WithdrawalViewController: UIViewController {
    
    // MARK: - UI Components
    
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
        withdrawalView.withdrawldelegate = self
    }
}

extension WithdrawalViewController: NavigationBarDelegate {
    
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {
    }
    
}

extension WithdrawalViewController: WithdrawlDelegate {
    func withdrawlButtonTapped() {
        self.makeAlert(alertType: .withdrawalAlert) {
            self.patchSignOutAPI()
        }
    }
}

// MARK: - Network
    
private extension WithdrawalViewController {
    func patchSignOutAPI() {
        AuthService.shared.patchSignOutAPI { NetworkResult in
            switch NetworkResult {
            case .success:
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let keyWindow = windowScene.windows.first else {
                    return
                }
                keyWindow.rootViewController = UINavigationController(rootViewController: LottieViewController())
                if let navigationController = keyWindow.rootViewController as? UINavigationController {
                    navigationController.isNavigationBarHidden = true
                }
            default:
                break
            }
        }
    }
}
