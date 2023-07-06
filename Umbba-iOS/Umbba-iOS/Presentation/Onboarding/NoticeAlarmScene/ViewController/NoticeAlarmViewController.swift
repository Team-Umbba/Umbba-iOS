//
//  NoticeAlarmViewController.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/05.
//

import UIKit

class NoticeAlarmViewController: UIViewController {

    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        view = NoticeAlarmView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationUI()
    }
}

// MARK: - Functions

extension NoticeAlarmViewController {
    func setNavigationUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .UmbbaBlack
    }

    @objc
    func backButtonTapped() {
        print("이전 화면으로 전환")
    }
}
