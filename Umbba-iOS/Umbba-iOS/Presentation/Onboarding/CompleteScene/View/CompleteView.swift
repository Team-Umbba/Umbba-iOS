//
//  CompleteView.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/09.
//

import UIKit

import SnapKit

final class CompleteView: UIView {
    
    // MARK: - UI Components
    
    private let completeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.completeTitle
        label.textColor = .UmbbaBlack
        label.font = .PretendardSemiBold(size: 24)
        label.numberOfLines = 0
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
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension CompleteView {
    func setUI() {
        self.backgroundColor = .UmbbaWhite
    }

    func setLayout() {
        self.addSubviews(completeTitleLabel, nextButton)
        
        completeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(12)
            $0.leading.equalToSuperview().inset(24)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
}
