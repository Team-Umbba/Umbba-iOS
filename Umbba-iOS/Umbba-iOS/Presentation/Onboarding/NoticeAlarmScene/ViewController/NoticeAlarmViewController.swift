//
//  NoticeAlarmViewController.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/05.
//

import UIKit

final class NoticeAlarmViewController: UIViewController {

    // MARK: - UI Components
    
    private let noticeAlarmView = NoticeAlarmView()
    private lazy var nextButton = noticeAlarmView.nextButton
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        view = noticeAlarmView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationUI()
        setAddTarget()
    }
}

// MARK: - Extensions

private extension NoticeAlarmViewController {
    func setNavigationUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .UmbbaBlack
    }
    
    func setAddTarget() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }

    @objc
    func backButtonTapped() {
        print("이전 화면으로 전환")
    }
    
    @objc
    func nextButtonTapped() {
//        self.navigationController?.pushViewController(InviteViewController(), animated: true)
        print("다음 화면으로 전환")
    }
}
