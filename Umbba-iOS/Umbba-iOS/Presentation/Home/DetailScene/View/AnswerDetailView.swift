//
//  AnswerDetailView.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/13.
//

import UIKit

import SnapKit

final class AnswerDetailView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: NavigationBarDelegate?
    weak var nextDelegate: NextButtonDelegate?
    
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
    
    private let partnerQeustLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.text = I18N.Detail.partnerQuestLabel
        label.font = .PretendardSemiBold(size: 20)
        return label
    }()
    
    private lazy var partnerAnswerView: UIView = {
        let answerView = UIView()
        answerView.backgroundColor = .white
        answerView.layer.borderWidth = 1
        answerView.layer.borderColor = UIColor.Gray400.cgColor
        answerView.layer.cornerRadius = 17
        return answerView
    }()
    
    private lazy var partnerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.text = I18N.Detail.partnerName
        label.font = .Cafe24Regular(size: 16)
        return label
    }()
    
    private let myQuestLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Detail.myQuestLabel
        label.font = .PretendardSemiBold(size: 20)
        return label
    }()
    
    private lazy var myAnswerView: UIView = {
        let answerView = UIView()
        answerView.backgroundColor = .white
        answerView.layer.borderWidth = 1
        answerView.layer.borderColor = UIColor.Gray400.cgColor
        answerView.layer.cornerRadius = 17
        return answerView
    }()
    
    private lazy var myNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.text = I18N.Detail.myName
        label.font = .Cafe24Regular(size: 16)
        return label
    }()
    
    private lazy var nextButton: CustomButton = {
        let button = CustomButton(status: true, title: I18N.Detail.answerButton)
        button.isEnabled = true
        return button
    }()

    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setAddTarget()
        setDelegate()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension AnswerDetailView {
    
    func setUI() {
        self.backgroundColor = .UmbbaWhite
    }
    
    func setAddTarget() {
        navigationBarView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    func setDelegate() {
        
    }
    
    func setLayout() {
        self.addSubviews(navigationBarView, themeStackView, nextButton, partnerQeustLabel, partnerAnswerView, myQuestLabel, myAnswerView)
        partnerAnswerView.addSubviews(partnerNameLabel)
        myAnswerView.addSubviews(myNameLabel)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        themeStackView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(9)
            $0.centerX.equalToSuperview()
        }
        
        partnerQeustLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalTo(themeStackView.snp.bottom).offset(50)
        }
        
        partnerAnswerView.snp.makeConstraints {
            $0.top.equalTo(partnerQeustLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(22)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 174 / 812)
        }
        
        partnerNameLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(16)
        }
        
        myQuestLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(partnerAnswerView.snp.bottom).offset(41)
        }
        
        myAnswerView.snp.makeConstraints {
            $0.top.equalTo(myQuestLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(22)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 174 / 812)
        }
        
        myNameLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(16)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
    @objc
    func backButtonTapped() {
        delegate?.backButtonTapped()
    }
    
    @objc
    func nextButtonTapped() {
        nextDelegate?.nextButtonTapped()
    }
}
