//
//  NoticeAlarmView.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/05.
//

import UIKit

import SnapKit

class NoticeAlarmView: UIView {
    
    // MARK: - UI Components
    
    private let timeNoticeLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.timeNotice
        label.numberOfLines = 2
        label.font = .PretendardSemiBold(size: 24)
        return label
    }()
    
    private let subNoticeLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.subNotice
        label.font = .PretendardRegular(size: 12)
        return label
    }()
    
    // MARK: - Life Cycles
        
    override init(frame: CGRect) {
        super.init(frame: frame)

        setUI()
        setDelegate()
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
        self.backgroundColor = .white
    }

    func setDelegate() {
    }

    func setAddTarget() {
    }

    func setLayout() {
        self.addSubviews(timeNoticeLabel, subNoticeLabel)
        
        timeNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(12)
            $0.leading.equalToSuperview().inset(24)
        }
        
        subNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(timeNoticeLabel.snp.bottom).offset(12)
            $0.leading.equalTo(timeNoticeLabel)
        }
    }
}
