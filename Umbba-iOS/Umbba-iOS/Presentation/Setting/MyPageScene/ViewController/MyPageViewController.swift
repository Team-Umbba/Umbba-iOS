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
    func presentViewTapped() {
       print("선물하기 탭으로 이동")
    }
    
    @objc
    func albumViewTapped() {
        print("기록하기 탭으로 이동")
    }
    
    @objc
    func relationViewTapped() {
        print("가까워지기 탭으로 이동")
    }
}

extension MyPageViewController: UIGestureRecognizerDelegate {
    func setGesture() {
        let presentTapGesture = UITapGestureRecognizer(target: self, action: #selector(presentViewTapped))
        mypageView.presentView.addGestureRecognizer(presentTapGesture)
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
