//
//  AnswerWriteView.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/10.
//

import UIKit

import SnapKit

protocol AnswerWriteDelegate: AnyObject {
    func answerDataBind(writePopUp: WritePopUp)
}

final class AnswerWriteView: UIView {
    
    // MARK: - Properties
    
    private var writePopUp: WritePopUp = WritePopUp()
    private var qusetionId: Int = 0
    
    weak var answerWriteDelegate: AnswerWriteDelegate?
    weak var navigationDelegate: NavigationBarDelegate?
    
    // MARK: - UI Components
    
    private let navigationBarView: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.cafe24Title = I18N.Write.navigationTitle
        view.isTitleViewIncluded = true
        view.isLeftButtonIncluded = true
        return view
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.text = I18N.Write.numberTitle
        label.font = .Cafe24Regular(size: 19)
        return label
    }()
    
    private let themeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.text = I18N.Write.themeTitle
        label.font = .Cafe24Regular(size: 20)
        return label
    }()
    
    private lazy var themeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.addArrangedSubviews(numberLabel, themeLabel)
        return stackView
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.text = I18N.Write.questionTitle
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .PretendardSemiBold(size: 20)
        return label
    }()
    
    private let answerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 17
        view.layer.borderColor = UIColor.Gray400.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let answerTextView: UITextView = {
        let textView = UITextView()
        textView.text = I18N.Write.answerPlaceholder
        textView.font = .PretendardRegular(size: 16)
        textView.textColor = .Gray800
        textView.textContainer.maximumNumberOfLines = 5
        textView.showsHorizontalScrollIndicator = false
        return textView
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.text = I18N.Write.countText
        label.font = .PretendardRegular(size: 10)
        return label
    }()
    
    private lazy var saveButton: CustomButton = {
        let button = CustomButton(status: false, title: I18N.Write.saveButtonTitle)
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setAddTarget()
        setDelegate()
        setLayout()
        setTodayData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension AnswerWriteView {
    func setUI() {
        self.backgroundColor = .UmbbaWhite
        self.addToolBar(textView: answerTextView)
    }
    
    func setAddTarget() {
        navigationBarView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
    func setDelegate() {
        answerTextView.delegate = self
    }
    
    func setLayout() {
        self.addSubviews(navigationBarView, themeStackView, questionLabel, answerView, saveButton)
        answerView.addSubviews(answerTextView, countLabel)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        themeStackView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(9)
            $0.centerX.equalToSuperview()
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(themeLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        answerView.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 174 / 812)
        }
        
        answerTextView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(44)
        }
        
        countLabel.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(16)
        }
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
    func setTodayData() {
        self.navigationBarView.cafe24Title = TodayData.shared.section
        self.numberLabel.text = "#\(TodayData.shared.index)"
        self.themeLabel.text = TodayData.shared.topic
        self.questionLabel.text = TodayData.shared.myQuestion
    }
    
    func checkMaxLength(_ textView: UITextView) {
        
        let maxLength = 100
        if textView.text.count > maxLength {
            textView.deleteBackward()
        }
        
        if textView.numberOfLines() < 6 {
            textView.isEditable = true
        } else {
            print("5줄까지만 입력이 가능합니다")
            textView.deleteBackward()
        }
    }
    
    func setData() {
        writePopUp.section = navigationBarView.cafe24Title
        writePopUp.topic = themeLabel.text
        writePopUp.question = questionLabel.text
        writePopUp.answer = answerTextView.text
        writePopUp.number = numberLabel.text
    }
    
    @objc
    func backButtonTapped() {
        navigationDelegate?.backButtonTapped()
    }
    
    @objc
    func completeButtonTapped() {
        setData()
        answerWriteDelegate?.answerDataBind(writePopUp: writePopUp)
        navigationDelegate?.completeButtonTapped()
    }
}

extension AnswerWriteView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .Gray800 {
            textView.text = nil
            textView.textColor = .UmbbaBlack
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = I18N.Write.answerPlaceholder
            textView.textColor = .Gray800
            saveButton.isEnabled = false
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
        countLabel.text = "(\(count)/100)"
        saveButton.isEnabled = count > 0 ? true : false
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
}
