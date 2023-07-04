//
//  InviteView.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/04.
//

import UIKit

import SnapKit

final class InviteView: UIView {
    
    // MARK: - UI Components
    
    private let inviteTitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.inviteTitle
        label.font = .PretendardRegular(size: 24)
        label.numberOfLines = 0
        label.setLineSpacingPartFontChange(lineSpacing: 5.0, targetString: I18N.Onboarding.inviteBoldTitle, font: .PretendardBold(size: 24))
        return label
    }()
    
    private lazy var inviteTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: I18N.Onboarding.inviteTextFieldPlaceholder)
        return textField
    }()
    
    private lazy var nextButton: CustomButton = {
        let button = CustomButton(status: false, title: I18N.Common.nextButtonTitle)
        button.isEnabled = false
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.inviteError
        label.font = .PretendardRegular(size: 12)
        label.textColor = UIColor.Error
        label.isHidden = true
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

private extension InviteView {
    func setUI() {
        self.backgroundColor = .white
    }
    
    func setDelegate() {
        inviteTextField.delegate = self
    }
    
    func setAddTarget() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    func setLayout() {
        self.addSubviews(inviteTitleLabel, inviteTextField, nextButton, errorLabel)
        
        inviteTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(12)
            $0.leading.equalToSuperview().inset(24)
        }
        
        inviteTextField.snp.makeConstraints {
            $0.top.equalTo(inviteTitleLabel.snp.bottom).offset(12)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(inviteTextField.snp.bottom).offset(4)
            $0.leading.equalTo(inviteTextField.snp.leading).offset(20)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(12)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
    @objc
    func nextButtonTapped() {
        // FixMe: - 초대코드 형식에 맞춰 수정 필요
        if inviteTextField.text?.isContainNumberAndAlphabet() == false {
            self.errorLabel.isHidden = false
            inviteTextField.textFieldStatus = .uncorrectedType
        } else {
            print("다음 화면으로 이동")
        }
    }
}

extension InviteView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.nextButton.isEnabled = textField.hasText
        if !textField.hasText {
            self.errorLabel.isHidden = true
            inviteTextField.textFieldStatus = .normal
        }
    }
}
