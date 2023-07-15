//
//  AnimationViewController.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/16.
//

import UIKit

class AnimationViewController: UIViewController {

    // MARK: - UI Components
    
    private let animationView = AnimationView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = animationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
    }
}

// MARK: - Extensions

extension AnimationViewController {
    func setDelegate() {
        animationView.nextDelegate = self
    }
}

extension AnimationViewController: NextButtonDelegate {
    func nextButtonTapped() {
        self.navigationController?.pushViewController(UserInfoViewController(), animated: true)
    }
}
