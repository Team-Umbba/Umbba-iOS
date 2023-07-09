//
//  PushAlarmViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/09.
//

import UIKit

final class PushAlarmViewController: UIViewController {
    
    private var pushAlarmTime: [String: Any] = [
        "hour": "1",
        "minute": "00",
        "period": "AM"
    ]
    
    private let pushAlarmView = PushAlarmView()
    private lazy var pickerView = pushAlarmView.timePickerView
    private lazy var nextButton = pushAlarmView.nextButton
    
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

extension PushAlarmViewController {
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
    
    @objc
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func nextButtonTapped() {
        self.navigationController?.pushViewController(CompleteViewController(), animated: true)
    }
}

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
