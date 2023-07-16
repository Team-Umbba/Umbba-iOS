//
//  CompleteViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/09.
//

import UIKit

final class CompleteViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let completeView = CompleteView()
    //    private let imageView = completeView.backgroundImageView
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = completeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            UIView.transition(with: self.completeView, duration: 1.0, options: .transitionCrossDissolve, animations: {
                self.updateUI()
            }, completion: nil)
        }
        setDelegate()
    }
}

// MARK: - Extensions

private extension CompleteViewController {
    
    func setDelegate() {
        completeView.navigationdelegate = self
        completeView.nextDelegate = self
    }
    
    func updateUI() {
        self.completeView.backgroundImageView.image = ImageLiterals.Onboarding.img_arrive
        self.completeView.completeTitleLabel.textColor = .UmbbaBlack
        self.completeView.navigationBarView.leftButton.tintColor = .UmbbaBlack
    }
}

extension CompleteViewController: NavigationBarDelegate {
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {
        
    }
}

extension CompleteViewController: NextButtonDelegate {
    func nextButtonTapped() {
        self.navigationController?.pushViewController(TabBarController(), animated: true)
    }
}
