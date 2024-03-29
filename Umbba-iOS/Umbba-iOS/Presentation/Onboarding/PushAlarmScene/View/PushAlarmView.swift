//
//  PushAlarmView.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/09.
//

import UIKit

import SnapKit

final class PushAlarmView: UIView {
    
    // MARK: - Properties
    
    weak var navigationdelegate: NavigationBarDelegate?
    weak var nextDelegate: NextButtonDelegate?
    
    // MARK: - UI Components
    
    private let navigationBarView: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.isLeftButtonIncluded = true
        return view
    }()
    
    private let timeMachineTitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.pushAlarmTitle
        label.font = .PretendardSemiBold(size: 24)
        label.textColor = .UmbbaBlack
        label.numberOfLines = 2
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
        let button = CustomButton(status: true, title: I18N.Common.nextButtonTitle)
        button.isEnabled = true
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setAddTarget()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension PushAlarmView {
    func setUI() {
        self.backgroundColor = .White500
    }
    
    func setAddTarget() {
        navigationBarView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    func setLayout() {
        self.addSubviews(navigationBarView, timeMachineTitleLabel, descriptionLabel, timePickerView, nextButton)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        timeMachineTitleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(12)
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
    
    @objc
    func backButtonTapped() {
        navigationdelegate?.backButtonTapped()
    }
    
    @objc
    func nextButtonTapped() {
        nextDelegate?.nextButtonTapped()
    }
}
