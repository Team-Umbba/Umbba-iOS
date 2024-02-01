//
//  LottieViewController.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/13.
//

import UIKit

import SnapKit
import Lottie

final class LottieViewController: UIViewController {
    // MARK: - UI Components
    
    private let lottieView = LottieView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = lottieView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.checkAppVersion()
        }
    }
    
}

// MARK: - Extensions

extension LottieViewController {
    func playAnimation() {
        lottieView.lottieSplashView.play { _ in
            if UserManager.shared.hasAccessToken {
                if UserManager.shared.haveUserName {
                    self.presentToMainView()
                } else {
                    self.presentToEntryView()
                }
            } else {
                self.presentToLoginView()
            }
        }
    }
    
    func presentToLoginView() {
        let nav = LoginViewController()
        self.navigationController?.pushViewController(nav, animated: false)
    }
    
    func presentToEntryView() {
        let nav = EntryViewController()
        self.navigationController?.pushViewController(nav, animated: false)
    }
    
    func presentToMainView() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first else {
            return
        }
        let nav = TabBarController()
        nav.selectedIndex = 0
        keyWindow.rootViewController = UINavigationController(rootViewController: nav)
        if let navigationController = keyWindow.rootViewController as? UINavigationController {
            navigationController.isNavigationBarHidden = true
        }
    }
    
    func checkAppVersion() {
        _ = try? AppStoreCheck.isUpdateAvailable { (update, error) in
            if let error = error {
                print(error)
            } else if let update = update {
                if update {
                    self.showUpdatePopUP()
                }
            }
        }
    }
    
    func showUpdatePopUP() {
        self.makeAlert(alertType: .updateAlert) {
            if let url = URL(string: "itms-apps://itunes.apple.com/app/id6450973870") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
}
