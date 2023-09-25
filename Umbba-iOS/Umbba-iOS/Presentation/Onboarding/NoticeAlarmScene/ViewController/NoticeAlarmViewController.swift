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
    var pushTime: String = ""
    
    // MARK: - UI Components

    private lazy var noticeAlarmView = NoticeAlarmView()
    private lazy var timeNoticeLabel = noticeAlarmView.timeNoticeLabel
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = noticeAlarmView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setDelegate()
        updateUI()
    }
    
}

// MARK: - Extensions

private extension NoticeAlarmViewController {
    
    func updateUI() {
        timeNoticeLabel.text = "매일 \(timeToString(pushTime))에\n교신을 보내줄게"
        timeNoticeLabel.partFontChange(targetString: timeToString(pushTime), font: .PretendardSemiBold(size: 24))
    }
    
    func setDelegate() {
        noticeAlarmView.navigationdelegate = self
        noticeAlarmView.nextDelegate = self
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func timeToString(_ time: String) -> String {
        let components = time.split(separator: ":")
        guard components.count == 2, let hour = Int(components[0]), let minute = Int(components[1]) else { return "" }

        let formattedhour = hour > 12 ? hour - 12 : hour
        switch (hour, minute) {
        case (0, 0):
            return "밤 12시"
        case (0, 30):
            return "밤 12시 반"
        case (1..<6, 0):
            return "새벽 \(formattedhour)시"
        case (1..<6, 30):
            return "새벽 \(formattedhour)시 반"
        case (6..<12, 0):
            return "아침 \(formattedhour)시"
        case (6..<12, 30):
            return "아침 \(formattedhour)시 반"
        case (12..<18, 0):
            return "낮 \(formattedhour)시"
        case (12..<18, 30):
            return "낮 \(formattedhour)시 반"
        case (18..<21, 0):
            return "저녁 \(formattedhour)시"
        case (18..<21, 30):
            return "저녁 \(formattedhour)시 반"
        case (21..<25, 0):
            return "밤 \(formattedhour)시"
        case (21..<25, 30):
            return "밤 \(formattedhour)시 반"
        default:
            return "올바른 형식이 아닙니다"
        }
    }
}

extension NoticeAlarmViewController: NavigationBarDelegate {
    @objc
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

extension NoticeAlarmViewController: UIGestureRecognizerDelegate {
    func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        view.addGestureRecognizer(tapGesture)
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
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner])
    }
}
