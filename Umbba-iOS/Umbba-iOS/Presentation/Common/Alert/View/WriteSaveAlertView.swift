//
//  WriteSaveView.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/11.
//

import UIKit

import SnapKit

final class WriteSaveWriteView: UIView {
    
    // MARK: - UI Components
    
    private let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .Primary500
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let cafe24TitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Write.navigationTitle
        label.textColor = .UmbbaWhite
        label.font = .Cafe24Regular(size: 16)
        return label
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
        label.font = .PretendardSemiBold(size: 20)
        return label
    }()
    
    private let answerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.text = ""
        label.textAlignment = .left
        label.font = .PretendardRegular(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let alertTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Alert.writeSaveTitle
        label.font = .PretendardRegular(size: 16)
        label.textColor = .UmbbaBlack
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .UmbbaWhite
        button.setTitleColor(.UmbbaBlack, for: .normal)
        button.setTitle(I18N.Alert.backButtonTitle, for: .normal)
        button.titleLabel?.font = .PretendardRegular(size: 16)
        button.layer.borderColor = UIColor.Gray400.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 24
        return button
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .Primary500
        button.setTitleColor(.UmbbaWhite, for: .normal)
        button.setTitle(I18N.Alert.saveButtonTitle, for: .normal)
        button.titleLabel?.font = .PretendardRegular(size: 16)
        button.layer.cornerRadius = 24
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 13
        stackView.addArrangedSubviews(cancelButton, confirmButton)
        return stackView
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

private extension WriteSaveWriteView {
    func setUI() {
        self.backgroundColor = .UmbbaWhite
        self.layer.cornerRadius = 16
    }
    
    func setAddTarget() {
        
    }
    
    func setLayout() {
        self.addSubviews(titleView, themeStackView, questionLabel, answerLabel, alertTitle, buttonStackView)
        titleView.addSubviews(cafe24TitleLabel)
        
        titleView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(32)
        }
        
        cafe24TitleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(49)
        }
        
        themeStackView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(9)
            $0.centerX.equalToSuperview()
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(themeStackView.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
        
        answerLabel.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(21)
            $0.bottom.equalTo(alertTitle.snp.top).offset(-66).priority(.high)
        }
        
        alertTitle.snp.makeConstraints {
            $0.top.equalTo(answerLabel.snp.bottom).offset(66)
            $0.centerX.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        confirmButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(alertTitle.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.bottom.equalToSuperview().inset(29)
        }
    }
}
