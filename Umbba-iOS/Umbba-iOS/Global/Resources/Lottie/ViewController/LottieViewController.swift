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
        let nav = TabBarController()
        self.navigationController?.pushViewController(nav, animated: false)
    }
}
