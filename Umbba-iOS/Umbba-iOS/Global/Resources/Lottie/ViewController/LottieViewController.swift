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
        lottieView.lottieSplashView.play { (finished) in
            self.moveToLoginView()
        }
    }
    
    func moveToLoginView() {
        let nav = LoginViewController()
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
}
