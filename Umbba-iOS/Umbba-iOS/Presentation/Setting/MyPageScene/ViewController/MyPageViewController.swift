//
//  MyPageViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 1/30/24.
//

import UIKit

import SnapKit

final class MyPageViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let mypageView = MyPageView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = mypageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
    }
}

// MARK: - Extensions

private extension MyPageViewController {
    func setDelegate() {
        mypageView.delegate = self
    }
}

extension MyPageViewController: SettingButtonDelegate {
    
    @objc
    func settingButtonTapped() {
        let settingViewController = SettingViewController()
        settingViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(settingViewController, animated: true)
    }
    
}
