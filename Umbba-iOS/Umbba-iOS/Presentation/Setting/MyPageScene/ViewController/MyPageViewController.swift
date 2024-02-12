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
        setGesture()
    }
}

// MARK: - Extensions

private extension MyPageViewController {
    func setDelegate() {
        mypageView.delegate = self
    }
    
    @objc
    func albumViewTapped() {
        let recordViewController = RecordViewController()
        recordViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(recordViewController, animated: true)
    }
    
    @objc
    func relationViewTapped() {
        let quizViewController = QuizViewController()
        quizViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(quizViewController, animated: true)
    }
}

extension MyPageViewController: UIGestureRecognizerDelegate {
    func setGesture() {
        let relationTapGesture = UITapGestureRecognizer(target: self, action: #selector(relationViewTapped))
        mypageView.relationView.addGestureRecognizer(relationTapGesture)
        let albumTapGesture = UITapGestureRecognizer(target: self, action: #selector(albumViewTapped))
        mypageView.albumView.addGestureRecognizer(albumTapGesture)
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
