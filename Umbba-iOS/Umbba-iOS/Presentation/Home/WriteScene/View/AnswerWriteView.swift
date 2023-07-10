//
//  AnswerWriteView.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/10.
//

import UIKit

import SnapKit

final class AnswerWriteView: UIView {
    
    // MARK: - UI Components
    
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
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setDelegate()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension AnswerWriteView {
    func setUI() {
        self.backgroundColor = .UmbbaWhite
    }
    
    func setDelegate() {
        answerTextView.delegate = self
    }
    
    func setLayout() {
        self.addSubviews(themeStackView, questionLabel, answerView)
        answerView.addSubviews(answerTextView, countLabel)
        
        themeStackView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(9)
            $0.centerX.equalToSuperview()
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(themeLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        answerView.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(172)
        }
        
        answerTextView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(44)
        }
        
        countLabel.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(16)
        }
    }
    
    func checkMaxLength(_ textView: UITextView) {
        if (textView.text.count) > 100 {
            textView.deleteBackward()
        }
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
            textView.text = "답변을 입력해주세요."
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
        countLabel.text = "(\(count)/100)"
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
}