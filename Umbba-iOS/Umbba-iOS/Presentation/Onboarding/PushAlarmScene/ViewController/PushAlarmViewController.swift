//
//  PushAlarmViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/09.
//

import UIKit
import UserNotifications

final class PushAlarmViewController: UIViewController {
    
    // MARK: - Properties
    
    var isReceiver: Bool = false
    private var pushAlarmTime: [String: Any] = [
        "hour": "11",
        "minute": "00",
        "period": "PM"
    ]
    private var formattedTime = ""
    
    // MARK: - UI Components
    
    private let pushAlarmView = PushAlarmView()
    private lazy var pickerView = pushAlarmView.timePickerView
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = pushAlarmView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setUI()
    }
}

// MARK: - Extensions

private extension PushAlarmViewController {
    
    func setUI() {
        let initialHourIndex = I18N.Onboarding.time.firstIndex(of: "11") ?? 0
        let initialMinuteIndex = I18N.Onboarding.minute.firstIndex(of: "00") ?? 0
        let initialAMIndex = I18N.Onboarding.am.firstIndex(of: "PM") ?? 0
        
        self.pickerView.selectRow(initialHourIndex, inComponent: 0, animated: false)
        self.pickerView.selectRow(initialMinuteIndex, inComponent: 1, animated: false )
        self.pickerView.selectRow(initialAMIndex, inComponent: 2, animated: false)
    }
    
    func setDelegate() {
        pushAlarmView.navigationdelegate = self
        pushAlarmView.nextDelegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    // MARK: - Functions
    
    func convertToTime(time: [String: Any]) {
        guard let hour = pushAlarmTime["hour"] as? String else { return }
        guard let minute = pushAlarmTime["minute"] as? String else { return }
        guard let period = pushAlarmTime["period"] as? String else { return }
        
        var hourString = hour
        
        if let hour = Int(hourString), let minute = Int(minute) {
            if period == "PM" {
                if hour != 12 {
                    hourString = String(hour + 12)
                }
            } else {
                if hour == 12 {
                    hourString = "00"
                }
            }
            formattedTime = String(format: "%02d:%02d", Int(hourString) ?? 0, minute)
        }
    }
}

extension PushAlarmViewController: NavigationBarDelegate {
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {
        
    }
}

extension PushAlarmViewController: NextButtonDelegate {
    func nextButtonTapped() {
        convertToTime(time: pushAlarmTime)
        print("\(formattedTime)")
        UserData.shared.pushTime = formattedTime
        //        let completeViewController = CompleteViewController()
        //        completeViewController.isReceiver = self.isReceiver
        requestPermission()
        //        self.navigationController?.pushViewController(completeViewController, animated: true)
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension PushAlarmViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return I18N.Onboarding.time.count
        } else if component == 1 {
            return I18N.Onboarding.minute.count
        } else {
            return I18N.Onboarding.am.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if component == 0 {
            let attributedString = NSAttributedString(string: I18N.Onboarding.time[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.UmbbaBlack])
            return attributedString
        } else if component == 1 {
            let attributedString = NSAttributedString(string: I18N.Onboarding.minute[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.UmbbaBlack])
            return attributedString
        } else {
            let attributedString = NSAttributedString(string: I18N.Onboarding.am[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.UmbbaBlack])
            return attributedString
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            pushAlarmTime["hour"] = I18N.Onboarding.time[row]
        } else if component == 1 {
            pushAlarmTime["minute"] = I18N.Onboarding.minute[row]
        } else {
            pushAlarmTime["period"] = I18N.Onboarding.am[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 60
    }
}

extension PushAlarmViewController: UNUserNotificationCenterDelegate {
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
//        UIApplication.shared.registerForRemoteNotifications()
    }
}
