//
//  InviteView.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/04.
//

import UIKit

import SnapKit

protocol InviteDelegate: AnyObject {
    func sendInviteCode(inviteCode: String)
}

final class InviteView: UIView {
    
    // MARK: - Properties
    
    weak var navigationdelegate: NavigationBarDelegate?
    weak var nextDelegate: NextButtonDelegate?
    weak var inviteDelegate: InviteDelegate?
    
    // MARK: - UI Components
    
    let navigationBarView: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.pretendardTitle = I18N.Onboarding.inviteNavigationTitle
        view.isLeftButtonIncluded = true
        return view
    }()
    
    private let inviteTitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.inviteTitle
        label.textColor = .UmbbaBlack
        label.font = .PretendardRegular(size: 24)
        label.setLineSpacingPartFontChange(lineSpacing: 5.0,
                                           targetString: I18N.Onboarding.inviteBoldTitle,
                                           font: .PretendardBold(size: 24))
        return label
    }()
    
    lazy var inviteTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: I18N.Onboarding.inviteTextFieldPlaceholder)
        return textField
    }()
    
    lazy var nextButton: CustomButton = {
        let button = CustomButton(status: false, title: I18N.Common.nextButtonTitle)
        button.isEnabled = false
        return button
    }()
    
    let errorLabel: UILabel = {
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
        self.backgroundColor = .White500
        self.addToolbar(textfields: [inviteTextField])
        if UserManager.shared.getInviteCode != "" {
            self.inviteTextField.text = UserManager.shared.inviteCode
            self.nextButton.isEnabled = true
        }
    }
    
    func setDelegate() {
        inviteTextField.delegate = self
    }
    
    func setAddTarget() {
        navigationBarView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    func setLayout() {
        self.addSubviews(navigationBarView, inviteTitleLabel, inviteTextField, nextButton, errorLabel)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        inviteTitleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(12)
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
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
    func setTextField(textField: UITextField) {
        guard let inviteCode = inviteTextField.text else { return }
        if !textField.hasText {
            self.errorLabel.isHidden = true
            inviteTextField.textFieldStatus = .normal
        } else {
            if !inviteCode.isValidInviteCode() {
                self.errorLabel.isHidden = false
                inviteTextField.textFieldStatus = .uncorrectedType
                nextButton.isEnabled = false
            } else {
                self.errorLabel.isHidden = true
                inviteTextField.textFieldStatus = .normal
                nextButton.isEnabled = true
            }
        }
    }
    
    @objc
    func backButtonTapped() {
        navigationdelegate?.backButtonTapped()
    }
    
    @objc
    func nextButtonTapped() {
        nextDelegate?.nextButtonTapped()
        guard let inviteCode = inviteTextField.text else { return }
        inviteDelegate?.sendInviteCode(inviteCode: inviteCode)
    }
}

// MARK: - UITextFieldDelegate

extension InviteView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        setTextField(textField: textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setTextField(textField: textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Keyboard Actions

extension InviteView {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            if SizeLiterals.Screen.deviceRatio > 0.5 {
                let bottomContraint = (keyboardHeight) * (-1) - 12
                nextButton.snp.updateConstraints {
                    $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(bottomContraint)
                }
            } else {
                let bottomContraint = (keyboardHeight) * (-1) + 20
                
                nextButton.snp.updateConstraints {
                    $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(bottomContraint)
                }
            }
        }
        UIView.animate(withDuration: duration, delay: 0) {
            self.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        nextButton.snp.updateConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
        }
        UIView.animate(withDuration: duration, delay: 0, options: .init(rawValue: curve)) {
            self.layoutIfNeeded()
        }
    }
}
