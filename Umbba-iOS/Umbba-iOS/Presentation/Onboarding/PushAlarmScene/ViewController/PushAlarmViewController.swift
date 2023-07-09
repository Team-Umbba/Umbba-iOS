//
//  PushAlarmViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/09.
//

import UIKit

final class PushAlarmViewController: UIViewController {
    
    // MARK: - Properties
    
    private var pushAlarmTime: [String: Any] = [
        "hour": "1",
        "minute": "00",
        "period": "AM"
    ]
    private var formattedTime = ""
    
    // MARK: - UI Components
    
    private let pushAlarmView = PushAlarmView()
    private lazy var pickerView = pushAlarmView.timePickerView
    private lazy var nextButton = pushAlarmView.nextButton
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = pushAlarmView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationUI()
        setAddTarget()
        setDelegate()
    }
}

// MARK: - Extensions

private extension PushAlarmViewController {
    func setNavigationUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    func setAddTarget() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    func setDelegate() {
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
            formattedTime = String(format: "%02d:%02d:00", Int(hourString) ?? 0, minute)
        }
    }
    
    @objc
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func nextButtonTapped() {
        convertToTime(time: pushAlarmTime)
        print("\(formattedTime)")
        self.navigationController?.pushViewController(CompleteViewController(), animated: true)
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
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return I18N.Onboarding.time[row]
        } else if component == 1 {
            return I18N.Onboarding.minute[row]
        } else {
            return I18N.Onboarding.am[row]
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
