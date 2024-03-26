//
//  ResultView.swift
//  Umbba-iOS
//
//  Created by 최영린 on 3/3/24.
//

import UIKit

final class ResultView: UIView {
    
    // MARK: - Properties
    
    weak var navigationdelegate: NavigationBarDelegate?
    weak var nextDelegate: NextButtonDelegate?
    
    // MARK: - UI Components
    
    private let navigationBarView: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.isLeftButtonIncluded = true
        view.backgroundColor = .White500
        return view
    }()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Quiz.QuizTitle
        label.font = .PretendardBold(size: 24)
        label.textColor = .UmbbaBlack
        return label
    }()
    
    private let balanceSubLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Quiz.QuizSubTitle
        label.font = .PretendardRegular(size: 16)
        label.textColor = .Gray900
        return label
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray300
        view.layer.borderColor = UIColor.Gray400.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 17
        return view
    }()
    
    private let labelView: UIView = {
        let view = UIView()
        view.backgroundColor = .Primary500
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let resultTitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Quiz.resultTitle
        label.font = .PretendardBold(size: 20)
        label.textColor = .White500
        return label
    }()
    
    private let resultView: UIView = {
        let view = UIView()
        view.backgroundColor = .White400
        view.layer.cornerRadius = 17
        view.layer.borderColor = UIColor.Gray400.cgColor
        return view
    }()
    
    private let myChoiceLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Quiz.myChoice
        label.font = .PretendardRegular(size: 14)
        label.textColor = .Gray800
        return label
    }()
    
    private var myAnswerLabel: UILabel = {
        let label = UILabel()
        label.font = .PretendardBold(size: 20)
        label.textColor = .Primary600
        return label
    }()
    
    private let lineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.MyPage.line_img
        return imageView
    }()
    
    private let opponentChoiceLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Quiz.opponentChoice
        label.font = .PretendardRegular(size: 14)
        label.textColor = .Gray800
        return label
    }()
    
    private let opponentAnswerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray800
        label.font = .PretendardBold(size: 20)
        return label
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.font = .PretendardBold(size: 20)
        return label
    }()
    
    lazy var nextButton: CustomButton = {
        let button = CustomButton(status: false, title: "다음으로")
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension ResultView {
    
    func setUI() {
        self.backgroundColor = .White500
    }
    
    func setAddTarget() {
        navigationBarView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    func setLayout() {
        self.addSubviews(navigationBarView, balanceLabel, balanceSubLabel, backgroundView, nextButton)
        backgroundView.addSubviews(labelView, resultView, resultLabel)
        labelView.addSubview(resultTitleLabel)
        resultView.addSubviews(myChoiceLabel, myAnswerLabel, lineImageView, opponentChoiceLabel, opponentAnswerLabel)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        balanceLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(24)
        }
        
        balanceSubLabel.snp.makeConstraints {
            $0.top.equalTo(balanceLabel.snp.bottom).offset(12)
            $0.leading.equalTo(balanceLabel.snp.leading)
        }
        
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(balanceSubLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(433)
        }
        
        labelView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(105)
            $0.height.equalTo(32)
        }
        
        resultTitleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        resultView.snp.makeConstraints {
            $0.top.equalTo(labelView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(272)
        }
        
        myChoiceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
        }
        
        myAnswerLabel.snp.makeConstraints {
            $0.top.equalTo(myChoiceLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        lineImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(60)
            $0.height.equalTo(50)
        }
        
        opponentAnswerLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
        }
        
        opponentChoiceLabel.snp.makeConstraints {
            $0.bottom.equalTo(opponentAnswerLabel.snp.top).offset(-12)
            $0.centerX.equalToSuperview()
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(resultView.snp.bottom).offset(28)
            $0.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
    @objc
    func backButtonTapped() {
        navigationdelegate?.backButtonTapped()
    }
    
    @objc
    func nextButtonTapped() {
        nextDelegate?.nextButtonTapped()
    }

    func updateUI(model: QuizEntity) {
        if model.opponentChoice == nil {
            labelView.backgroundColor = .Gray800
            lineImageView.image = ImageLiterals.Quiz.grayLine_img
            resultLabel.textColor = .Gray900
            resultLabel.snp.updateConstraints {
                $0.top.equalTo(resultView.snp.bottom).offset(16)
            }
            resultLabel.textAlignment = .center
            resultLabel.text = I18N.Quiz.result_notyet
            resultLabel.numberOfLines = 2
        } else if model.myChoice == model.opponentChoice {
            opponentAnswerLabel.textColor = .Primary600
            resultLabel.textColor = .Primary600
            resultLabel.text = I18N.Quiz.result_correct
            nextButton.isEnabled = true
        } else {
            opponentAnswerLabel.textColor = .Gray900
            lineImageView.image = ImageLiterals.Quiz.grayLine_img
            resultLabel.textColor = .Gray900
            resultLabel.text = I18N.Quiz.result_incorrect
            nextButton.isEnabled = true
        }
    }
}

extension ResultView {
    func setDataBind(model: QuizEntity) {
        myAnswerLabel.text = model.myChoice
        opponentAnswerLabel.text = model.opponentChoice != nil ? model.opponentChoice : "-"
        updateUI(model: model)
    }
}
