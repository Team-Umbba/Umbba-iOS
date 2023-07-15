//
//  WriteSaveView.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/11.
//

import UIKit

import SnapKit

final class WriteSaveAlertView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: AlertDelegate?
    
    // MARK: - UI Components
    
    private let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .Primary500
        view.layer.cornerRadius = 16
        return view
    }()
    
    var cafe24TitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .UmbbaWhite
        label.font = .Cafe24Regular(size: 16)
        return label
    }()
    
    var numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.text = ""
        label.font = .Cafe24Regular(size: 19)
        return label
    }()
    
    var themeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.text = ""
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
    
    var questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .PretendardSemiBold(size: 20)
        return label
    }()
    
    var answerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.text = ""
        label.textAlignment = .center
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

private extension WriteSaveAlertView {
    func setUI() {
        self.backgroundColor = .UmbbaWhite
        self.layer.cornerRadius = 16
    }
    
    func setAddTarget() {
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
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
    
    // MARK: - @objc Functions
    
    @objc func cancelButtonTapped() {
        delegate?.alertDismissTapped()
    }
    
    @objc func confirmButtonTapped() {
        delegate?.colorButtonTapped()
    }
}
