//
//  AnimationViewController.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/16.
//

import UIKit

final class AnimationViewController: UIViewController {

    // MARK: - Properties
    
    var isReceiver: Bool = false
    
    // MARK: - UI Components
    
    private let animationView = AnimationView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = animationView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async {
            self.animationView.playVideo()
        }
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
        let userInfoViewController =  UserInfoViewController()
        self.navigationController?.pushViewController(userInfoViewController, animated: true)
        userInfoViewController.isReceiver = self.isReceiver
    }
}
