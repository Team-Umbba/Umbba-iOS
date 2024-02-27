//
//  AnswerDetailView.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/13.
//

import UIKit

import SnapKit

// MARK: - Protocols

protocol HomeButtonDelegate: AnyObject {
    func homeButtonTapped()
}

final class AnswerDetailView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: NavigationBarDelegate?
    weak var nextDelegate: NextButtonDelegate?
    weak var homeDelegate: HomeButtonDelegate?
    
    // MARK: - UI Components
    
    private let navigationBarView: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.isTitleViewIncluded = true
        view.isLeftButtonIncluded = true
        return view
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.font = .Cafe24Regular(size: 19)
        return label
    }()
    
    private let themeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
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
    
    let partnerQuestLabel: BlurLabel = {
        let label = BlurLabel()
        label.textColor = .UmbbaBlack
        label.font = .PretendardSemiBold(size: 20)
        label.numberOfLines = 0
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
    
    lazy var partnerAnswerContent: BlurLabel = {
        let label = BlurLabel()
        label.textColor = .UmbbaBlack
        label.font = .PretendardRegular(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let partnerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray800
        label.text = I18N.Detail.noneAnswer
        label.font = .PretendardRegular(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var partnerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.font = .Cafe24Regular(size: 16)
        return label
    }()
    
    private let myQuestLabel: UILabel = {
        let label = UILabel()
        label.font = .PretendardSemiBold(size: 20)
        label.textAlignment = .right
        label.numberOfLines = 0
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
        label.font = .Cafe24Regular(size: 16)
        return label
    }()
    
    private lazy var myAnswerContent: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray800
        label.text = I18N.Detail.pleaseAnswer
        label.font = .PretendardRegular(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var nextButton: CustomButton = {
        let button = CustomButton(status: true, title: I18N.Detail.answerButton)
        button.isEnabled = true
        return button
    }()
    
    private lazy var homeButton: CustomButton = {
        let button = CustomButton(status: false, title: I18N.Detail.homeButton)
        button.layer.borderColor = UIColor.Primary500.cgColor
        button.layer.borderWidth = 2
        button.setBackgroundColor(.White500, for: .normal)
        button.setTitleColor(.Primary500, for: .normal)
        button.adjustsImageWhenHighlighted = false
        button.isEnabled = true
        button.isHidden = true
        return button
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

private extension AnswerDetailView {
    
    func setUI() {
        self.backgroundColor = .White500
    }
    
    func setAddTarget() {
        navigationBarView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
    }
    
    func setLayout() {
        self.addSubviews(navigationBarView, themeStackView, nextButton, homeButton, partnerAnswerView, myAnswerView)
        partnerAnswerView.addSubviews(partnerQuestLabel, partnerNameLabel, partnerLabel, partnerAnswerContent)
        myAnswerView.addSubviews(myQuestLabel, myNameLabel, myLabel, myAnswerContent)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        themeStackView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(9)
            $0.centerX.equalToSuperview()
        }
        
        partnerAnswerView.snp.makeConstraints {
            $0.top.equalTo(themeStackView.snp.bottom).offset(24)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 60)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 212 / 812)
        }
        
        partnerQuestLabel.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview().inset(16)
        }
        
        partnerNameLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(16)
        }
        
        partnerAnswerContent.snp.makeConstraints {
            $0.top.equalTo(partnerQuestLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        partnerLabel.snp.makeConstraints {
            $0.top.equalTo(partnerQuestLabel.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
        
        myAnswerView.snp.makeConstraints {
            $0.top.equalTo(partnerAnswerView.snp.bottom).offset(16)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 60)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 212 / 812)
        }
        
        myQuestLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
        }
        
        myNameLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(16)
        }
        
        myLabel.snp.makeConstraints {
            $0.top.equalTo(myQuestLabel.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
        
        myAnswerContent.snp.makeConstraints {
            $0.top.equalTo(myQuestLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        homeButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.centerX.equalToSuperview()
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
    
    @objc
    func homeButtonTapped() {
        homeDelegate?.homeButtonTapped()
    }
    
    @objc
    func handleTap(sender: UITapGestureRecognizer) {
        nextDelegate?.nextButtonTapped()
    }
    
    func setButton(isNextButton: Bool) {
        nextButton.isHidden = !isNextButton
        homeButton.isHidden = isNextButton
    }
    
    func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        myAnswerView.addGestureRecognizer(tapGesture)
    }
    
    func removeGesture() {
        for gestureRecognizer in myAnswerView.gestureRecognizers ?? [] {
            myAnswerView.removeGestureRecognizer(gestureRecognizer)
        }
    }
}

extension AnswerDetailView {
    
    func setTodayDataBind(model: TodayEntity) {
        guard let isMyAnswer = model.isMyAnswer else { return }
        guard let isOpponentAnswer = model.isOpponentAnswer else { return }
        
        navigationBarView.cafe24Title = model.section
        numberLabel.text = "#\(model.index ?? 0)"
        themeLabel.text = model.topic
        partnerQuestLabel.text = model.opponentQuestion
        partnerNameLabel.text = model.opponentUsername
        myQuestLabel.text = model.myQuestion
        myNameLabel.text = model.myUsername
        
        switch (isMyAnswer, isOpponentAnswer) {
        case (false, false):
            myAnswerView.layer.borderColor = UIColor.Primary500.cgColor
            myAnswerView.backgroundColor = .Primary400
            partnerQuestLabel.blurRadius = 20
            setGesture()
            setButton(isNextButton: true)
        case (true, false):
            myAnswerContent.text = model.myAnswer
            myLabel.isHidden = true
            removeGesture()
            setButton(isNextButton: false)
        case (false, true):
            myAnswerView.layer.borderColor = UIColor.Primary500.cgColor
            myAnswerView.backgroundColor = .Primary400
            partnerAnswerContent.blurRadius = 20
            partnerLabel.text = I18N.Detail.yetAnswer
            partnerAnswerContent.text = model.opponentAnswer
            setGesture()
            setButton(isNextButton: true)
        case (true, true):
            myAnswerContent.text = model.myAnswer
            partnerAnswerContent.text = model.opponentAnswer
            partnerLabel.isHidden = true
            myLabel.isHidden = true
            removeGesture()
            setButton(isNextButton: false)
        }
    }
    
    func setDetailDataBind(model: DetailEntity) {
        if model.myAnswer != "" && model.myQuestion != "" {
            myAnswerContent.textColor = .UmbbaBlack
            partnerAnswerContent.textColor = .UmbbaBlack
            nextButton.isHidden = true
            homeButton.isHidden = false
        }
        navigationBarView.cafe24Title = model.section
        numberLabel.text = "#\(model.index)"
        themeLabel.text = model.topic
        partnerQuestLabel.text = model.opponentQuestion
        partnerNameLabel.text = model.opponentUsername
        myQuestLabel.text = model.myQuestion
        myNameLabel.text = model.myUsername
        myAnswerContent.text = model.myAnswer
        partnerAnswerContent.text = model.opponentAnswer
    }
}
