//
//  PushAlarmView.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/09.
//

import UIKit

import SnapKit

final class PushAlarmView: UIView {
        
        // MARK: - UI Components
        
        private let timeMachineTitleLabel: UILabel = {
            let label = UILabel()
            label.text = I18N.Onboarding.pushAlarmTitle
            label.font = .PretendardSemiBold(size: 24)
            label.textColor = .UmbbaBlack
            label.numberOfLines = 0
            return label
        }()
        
        private let descriptionLabel: UILabel = {
            let label = UILabel()
            label.text = I18N.Onboarding.pushAlarmDescription
            label.font = .PretendardRegular(size: 12)
            label.textColor = .Gray800
            return label
        }()
        
        lazy var timePickerView: UIPickerView = {
            let pickerView = UIPickerView()
            pickerView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
            return pickerView
        }()
        
        lazy var nextButton: CustomButton = {
            let button = CustomButton(status: true, title:  I18N.Common.nextButtonTitle)
            button.isEnabled = true
            return button
        }()
        
        // MARK: - Life Cycles
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setUI()
            setLayout()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    // MARK: - Extensions

private extension PushAlarmView {
    func setUI() {
        self.backgroundColor = .UmbbaWhite
    }
    
    func setLayout() {
        self.addSubviews(timeMachineTitleLabel, descriptionLabel, timePickerView, nextButton)
        
        timeMachineTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(12)
            $0.leading.equalToSuperview().inset(24)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(timeMachineTitleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(timeMachineTitleLabel.snp.leading)
        }
        
        timePickerView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
}
