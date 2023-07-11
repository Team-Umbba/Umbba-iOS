//
//  NoticeAlarmView.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/05.
//

import UIKit

import SnapKit

final class NoticeAlarmView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: NavigationBarDelegate?
    
    // MARK: - UI Components
    
    private let navigationBarView: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.isLeftButtonIncluded = true
        return view
    }()
    
    private let explainLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.timeExplain
        label.textColor = .UmbbaBlack
        label.font = .PretendardRegular(size: 16)
        return label
    }()
    
    private let timeNoticeLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.timeNotice
        label.textColor = .UmbbaBlack
        label.numberOfLines = 2
        label.font = .PretendardRegular(size: 24)
        label.partFontChange(targetString: "11시", font: .PretendardSemiBold(size: 24))
        return label
    }()
    
    private let subNoticeLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.subNotice
        label.textColor = .Gray800
        label.font = .PretendardRegular(size: 12)
        return label
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

private extension NoticeAlarmView {
    func setUI() {
        self.backgroundColor = .UmbbaWhite
    }
    
    func setAddTarget() {
        navigationBarView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    func setLayout() {
        self.addSubviews(navigationBarView, explainLabel, timeNoticeLabel, subNoticeLabel, nextButton)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(24)
        }
        
        timeNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(explainLabel.snp.bottom).offset(12)
            $0.leading.equalTo(explainLabel.snp.leading)
        }
        
        subNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(timeNoticeLabel.snp.bottom).offset(12)
            $0.leading.equalTo(explainLabel.snp.leading)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
    @objc
    func backButtonTapped() {
        delegate?.backButtonTapped()
    }
}
