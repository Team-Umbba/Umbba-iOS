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
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = noticeAlarmView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setDelegate()
    }
}

// MARK: - Extensions

private extension NoticeAlarmViewController {

    func setDelegate() {
        noticeAlarmView.navigationdelegate = self
        noticeAlarmView.nextDelegate = self
    }
}

extension NoticeAlarmViewController: NavigationBarDelegate {
    func backButtonTapped() {
        print("이전화면으로 이동")
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {

    }
}

extension NoticeAlarmViewController: NextButtonDelegate {
    func nextButtonTapped() {
        self.navigationController?.pushViewController(CompleteViewController(), animated: true)
        print("다음 화면으로 전환")
    }
}
