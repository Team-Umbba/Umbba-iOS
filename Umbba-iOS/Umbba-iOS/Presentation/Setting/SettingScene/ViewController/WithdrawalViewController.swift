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
        self.dismiss(animated: false)
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
                UserManager.shared.clearAll()
                keyWindow.rootViewController = UINavigationController(rootViewController: LottieViewController())
                if let navigationController = keyWindow.rootViewController as? UINavigationController {
                    navigationController.isNavigationBarHidden = true
                }
            case .requestErr, .serverErr:
                self.makeAlert(title: "오류가 발생했습니다", message: "다시 시도해주세요")
            default:
                break
            }
        }
    }
}
