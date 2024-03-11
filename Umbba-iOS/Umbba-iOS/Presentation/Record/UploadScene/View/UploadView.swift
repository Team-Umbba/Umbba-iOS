//
//  UploadView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2/27/24.
//

import UIKit

import SnapKit

final class UploadView: UIView {

    // MARK: - Properties
    
    weak var navigationdelegate: NavigationBarDelegate?
    
    // MARK: - UI Components
    
    private let navigationBarView: CustomNavigationBar = {
        let navigation = CustomNavigationBar()
        navigation.isLeftButtonIncluded = true
        return navigation
    }()
    
    private let uploadTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "기록하기"
        label.textColor = .UmbbaBlack
        label.font = .PretendardSemiBold(size: 24)
        return label
    }()
    
    private let uploadSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "간단한 설명과 함께 사진을 업로드 하세요"
        label.textColor = .Gray900
        label.font = .PretendardRegular(size: 16)
        return label
    }()
    
    private let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.5)
        view.layer.borderColor = UIColor.Gray400.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.textColor = .UmbbaBlack
        label.font = .PretendardSemiBold(size: 20)
        return label
    }()
    
    let titleTextField = CustomTextField(placeHolder: "사진의 제목을 작성해주세요")
    
    let titleErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "*최대 15자까지 입력 가능합니다."
        label.textColor = .Error
        label.font = .PretendardRegular(size: 12)
        return label
    }()
    
    private let introduceView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.5)
        view.layer.borderColor = UIColor.Gray400.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let introduceLabel: UILabel = {
        let label = UILabel()
        label.text = "소개"
        label.textColor = .UmbbaBlack
        label.font = .PretendardSemiBold(size: 20)
        return label
    }()
    
    let introduceTextView: UITextView = {
        let textView = UITextView()
        textView.text = "사진에 대해 소개해주세요"
        textView.font = .PretendardRegular(size: 16)
        textView.textColor = .Gray800
        textView.textContainer.maximumNumberOfLines = 5
        textView.showsHorizontalScrollIndicator = false
        textView.backgroundColor = .white.withAlphaComponent(0.56)
        textView.layer.borderColor = UIColor.Gray400.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 17
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        return textView
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.text = "0/32"
        label.font = .PretendardRegular(size: 10)
        return label
    }()
    
    lazy var uploadButton = CustomButton(status: false, title: "등록하기")
    
    let uploadCancelView = UploadCancelView()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
        setDelegate()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension UploadView {

    func setUI() {
        backgroundColor = .White500
        titleErrorLabel.isHidden = true
        uploadCancelView.isHidden = true
    }
    
    func setHierarchy() {
        titleView.addSubviews(titleLabel, titleTextField, titleErrorLabel)
        introduceView.addSubviews(introduceLabel, introduceTextView, countLabel)
        addSubviews(navigationBarView, uploadTitleLabel, uploadSubTitleLabel, titleView, introduceView, uploadButton, uploadCancelView)
    }
    
    func setLayout() {
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        uploadTitleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(24)
        }
        
        uploadSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(uploadTitleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(uploadTitleLabel.snp.leading)
        }
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(uploadSubTitleLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 48)
            $0.height.equalTo(136)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(24)
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 96)
            $0.height.equalTo(48)
        }
        
        titleErrorLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(44)
        }
        
        introduceView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 48)
            $0.height.equalTo(192)
        }
        
        introduceLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(24)
        }
        
        introduceTextView.snp.makeConstraints {
            $0.top.equalTo(introduceLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 96)
            $0.height.equalTo(104)
        }
        
        countLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(44)
            $0.trailing.equalToSuperview().inset(40)
        }
        
        uploadButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(60)
        }
        
        uploadCancelView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setAddTarget() {
        navigationBarView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func backButtonTapped() {
        navigationdelegate?.backButtonTapped()
    }
    
    func setDelegate() {
        introduceTextView.delegate = self
        titleTextField.delegate = self
    }
    
    func checkMaxLength(_ textView: UITextView) {
        
        let maxLength = 32
        if textView.text.count > maxLength {
            textView.deleteBackward()
        }
        
        if textView.numberOfLines() <= 2 {
            textView.isEditable = true
        } else {
            textView.deleteBackward()
        }
    }
    
    func updateUploadButton() {

        if !titleTextField.isEmpty && introduceTextView.text != "사진에 대해 소개해주세요" && introduceTextView.text.count > 0 {
            uploadButton.isEnabled = true
        } else {
            uploadButton.isEnabled = false
        }
    }
}

extension UploadView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .Gray800 {
            textView.text = nil
            textView.textColor = .UmbbaBlack
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "사진에 대해 소개해주세요"
            textView.textColor = .Gray800
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: self.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if estimatedSize.height >= 277 {
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                }
            }
        }
        checkMaxLength(textView)
        let count = textView.text.count
        countLabel.text = "(\(count)/32)"
        updateUploadButton()
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
}

extension UploadView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newText = (text as NSString).replacingCharacters(in: range, with: string)
        if newText.count > 15 {
            if let customTextField = textField as? CustomTextField {
                customTextField.textFieldStatus = .uncorrectedType
                customTextField.textColor = .Error
            }
            titleErrorLabel.isHidden = false
        } else {
            if let customTextField = textField as? CustomTextField {
                customTextField.textFieldStatus = .normal
                customTextField.textColor = .UmbbaBlack
            }
            titleErrorLabel.isHidden = true
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let currentText = textField.text ?? ""
        if currentText.isEmpty {
            if let customTextField = textField as? CustomTextField {
                customTextField.textFieldStatus = .normal
            }
            titleErrorLabel.isHidden = true
        }
        updateUploadButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
}
