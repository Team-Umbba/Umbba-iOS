//
//  UserInfoView.swift
//  Umbba-Lab
//
//  Created by 최영린 on 2023/07/06.
//

import UIKit

import SnapKit

final class UserInfoView: UIView {
    
    // MARK: - Properties
    
    weak var navigationdelegate: NavigationBarDelegate?
    weak var nextDelegate: NextButtonDelegate?
    
    private var selectedButton: Int = 0
    private var genderButton: [UIButton] = []
    private var gender: String = ""
    
    // MARK: - UI Components
    
    private let navigationBarView: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.isLeftButtonIncluded = true
        return view
    }()
    
    private let userInfoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.userInfoTitle
        label.textColor = .UmbbaBlack
        label.font = .PretendardRegular(size: 24)
        label.setLineSpacingPartFontChange(lineSpacing: 5.0, targetString: "너", font: .PretendardBold(size: 24))
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .UmbbaWhite
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.Gray400.cgColor
        view.layer.masksToBounds = true
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.nameInfo
        label.textColor = .UmbbaBlack
        label.font = .PretendardSemiBold(size: 20)
        return label
    }()
    
    private lazy var nameTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: I18N.Onboarding.namePlaceholder)
        return textField
    }()
    
    private let nameErrorLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.nameError
        label.font = .PretendardRegular(size: 12)
        label.textColor = UIColor.Error
        label.isHidden = true
        return label
    }()
    
    private let genderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.Gray400.cgColor
        view.layer.masksToBounds = true
        return view
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.genderInfo
        label.textColor = .UmbbaBlack
        label.font = .PretendardSemiBold(size: 20)
        return label
    }()
    
    private lazy var maleButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.UmbbaWhite, for: .normal)
        button.setBackgroundColor(.Primary500, for: .selected)
        button.setTitle(I18N.Onboarding.male, for: .normal)
        button.setTitleColor(.UmbbaBlack, for: .normal)
        button.setTitleColor(.UmbbaWhite, for: .selected)
        button.titleLabel?.font = .PretendardRegular(size: 16)
        button.layer.borderColor = UIColor.Gray400.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 24
        button.adjustsImageWhenHighlighted = false
        genderButton.append(button)
        return button
    }()
    
    private lazy var femaleButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.UmbbaWhite, for: .normal)
        button.setBackgroundColor(.Primary500, for: .selected)
        button.setTitle(I18N.Onboarding.female, for: .normal)
        button.setTitleColor(.UmbbaBlack, for: .normal)
        button.setTitleColor(.UmbbaWhite, for: .selected)
        button.titleLabel?.font = .PretendardRegular(size: 16)
        button.layer.borderColor = UIColor.Gray400.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 24
        button.adjustsImageWhenHighlighted = false
        genderButton.append(button)
        return button
    }()
    
    private lazy var genderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 13
        stackView.addArrangedSubviews(maleButton, femaleButton)
        return stackView
    }()
    
    private let birthView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.Gray400.cgColor
        view.layer.masksToBounds = true
        return view
    }()
    
    private let birthLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.birthInfo
        label.textColor = .UmbbaBlack
        label.font = .PretendardSemiBold(size: 20)
        return label
    }()
    
    private lazy var birthTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: I18N.Onboarding.birthPlaceholder)
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let birthErrorLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.birthError
        label.font = .PretendardRegular(size: 12)
        label.textColor = UIColor.Error
        label.isHidden = true
        return label
    }()
    
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 12
        stackView.addArrangedSubviews(nameView, genderView, birthView)
        return stackView
    }()
    
    lazy var nextButton: CustomButton = {
        let button = CustomButton(status: false, title: I18N.Common.nextButtonTitle)
        button.isEnabled = false
        return button
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

private extension UserInfoView {
    func setUI() {
        self.backgroundColor = .UmbbaWhite
        self.addToolbar(textfields: [nameTextField, birthTextField])
    }
    
    func setDelegate() {
        nameTextField.delegate = self
        birthTextField.delegate = self
    }
    
    func setAddTarget() {
        navigationBarView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        maleButton.addTarget(self, action: #selector(genderButtonTapped), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(genderButtonTapped), for: .touchUpInside)
    }
    
    func setLayout() {
        self.addSubviews(navigationBarView, userInfoTitleLabel, scrollView, nextButton)
        scrollView.addSubview(contentView)
        contentView.addSubviews(infoStackView)
        nameView.addSubviews(nameLabel, nameTextField, nameErrorLabel)
        genderView.addSubviews(genderLabel, genderStackView)
        birthView.addSubviews(birthLabel, birthTextField, birthErrorLabel)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        userInfoTitleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(24)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(userInfoTitleLabel.snp.bottom).offset(20)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.height.greaterThanOrEqualTo(self.snp.height).priority(.low)
            $0.width.equalTo(scrollView.snp.width)
        }
        
        infoStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        nameView.snp.makeConstraints {
            $0.height.equalTo(136)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(24)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(12)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        
        nameErrorLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(4)
            $0.leading.equalTo(nameTextField.snp.leading).offset(20)
        }
        
        genderView.snp.makeConstraints {
            $0.height.equalTo(136)
        }
        
        genderLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(24)
        }
        
        maleButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        femaleButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        genderStackView.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
        
        birthView.snp.makeConstraints {
            $0.height.equalTo(136)
        }
        
        birthLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(24)
        }
        
        birthTextField.snp.makeConstraints {
            $0.top.equalTo(birthLabel.snp.bottom).offset(12)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        
        birthErrorLabel.snp.makeConstraints {
            $0.top.equalTo(birthTextField.snp.bottom).offset(4)
            $0.leading.equalTo(birthTextField.snp.leading).offset(20)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
    // MARK: - Functions
    
    func isFilledAnswer() -> Bool {
        if nameTextField.hasText && birthTextField.hasText && (maleButton.isSelected || femaleButton.isSelected) {
            return true
        } else {
            return false
        }
    }
    
    func isCorrectedStatus() -> Bool {
        if birthTextField.textFieldStatus == .normal && nameTextField.textFieldStatus == .normal {
            return true
        } else {
            return false
        }
    }
    
    func updateNextButton() {
        if  isFilledAnswer() && !isCorrectedStatus() {
            nextButton.isEnabled = false
        } else if !isFilledAnswer() {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
    }
    
    func updateNameErrorLabel(isError: Bool) {
        self.nameErrorLabel.isHidden = !isError
        nameTextField.textFieldStatus = isError ? .uncorrectedType : .normal
    }
    
    func updateBirthErrorLabel(isError: Bool) {
        self.birthErrorLabel.isHidden = !isError
        birthTextField.textFieldStatus = isError ? .uncorrectedType : .normal
    }
    
    // MARK: - @objc Functions
    
    @objc
    func backButtonTapped() {
        navigationdelegate?.backButtonTapped()
    }
    
    @objc
    func nextButtonTapped() {
        nextDelegate?.nextButtonTapped()
        UserData.shared.userInfo.name = nameTextField.text ?? ""
        UserData.shared.userInfo.gender = gender
        UserData.shared.userInfo.bornYear = Int(birthTextField.text ?? "") ?? 0
    }
    
    @objc
    func genderButtonTapped(sender: UIButton) {
        updateNextButton()
        self.selectedButton = sender.tag
        genderButton.forEach { button in
            guard let gender = button.titleLabel?.text else { return }
            button.isSelected = sender == button
            if button.isSelected {
                print(gender)
                self.gender = gender
            }
        }
    }
}

// MARK: - TextFieldDelegate

extension UserInfoView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateNextButton()
        if nameTextField.hasText && nameTextField.text?.isOnlyKorean() == false {
            updateNameErrorLabel(isError: true)
        } else {
            updateNameErrorLabel(isError: false)
        }
        if birthTextField.hasText && (birthTextField.text?.count == 4) {
            updateBirthErrorLabel(isError: false)
        } else if !birthTextField.hasText || birthTextField.text?.count ?? 0 < 4 {
            birthTextField.textFieldStatus = .editing
            self.nextButton.isEnabled = false
        } else {
            updateBirthErrorLabel(isError: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateNextButton()
        if nameTextField.hasText && nameTextField.text?.isOnlyKorean() == false {
            updateNameErrorLabel(isError: true)
        } else {
            updateNameErrorLabel(isError: false)
        }
        if birthTextField.hasText && (birthTextField.text?.count != 4) {
            updateBirthErrorLabel(isError: true)
        } else {
            updateBirthErrorLabel(isError: false)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField.text!.count < 7 else { return false } // 10 글자로 제한
        return true
    }
}
