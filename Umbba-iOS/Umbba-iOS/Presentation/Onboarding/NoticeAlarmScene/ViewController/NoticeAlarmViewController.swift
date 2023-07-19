//
//  NoticeAlarmViewController.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/05.
//

import UIKit
import UserNotifications

final class NoticeAlarmViewController: UIViewController {

    // MARK: - Properties
    
    var isReceiver: Bool = false
    
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
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {

    }
}

extension NoticeAlarmViewController: NextButtonDelegate {
    func nextButtonTapped() {
        requestPermission()
    }
}

extension NoticeAlarmViewController: UNUserNotificationCenterDelegate {
    func requestPermission() {
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { didAllow, error in
            print(didAllow)
            DispatchQueue.main.async {
                let completeViewController = CompleteViewController()
                completeViewController.isReceiver = self.isReceiver
                self.navigationController?.pushViewController(completeViewController, animated: true)
            }
        }
    }
}

