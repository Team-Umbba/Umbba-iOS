//
//  QuizView.swift
//  Umbba-iOS
//
//  Created by 최영린 on 1/31/24.
//

import UIKit

final class QuizView: UIView {
    
    // MARK: - UI Components
    
    private let navigationBarView: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.isLeftButtonIncluded = true
        view.backgroundColor = .White500
        return view
    }()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "밸런스 게임!"
        label.font = .PretendardBold(size: 24)
        label.textColor = .UmbbaBlack
        return label
    }()
    
    private let balanceSubLabel: UILabel = {
        let label = UILabel()
        label.text = "나는 상대방에 대해 얼마나 알고 있을까?"
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
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "겨울에는"
        label.textColor = .UmbbaBlack
        label.font = .PretendardBold(size: 20)
        return label
    }()
    
    private lazy var answerButton1: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.White500, for: .normal)
        button.setBackgroundColor(.Primary400, for: .selected)
        button.setTitle("팥 붕어빵", for: .normal)
        button.setTitleColor(.Gray900, for: .normal)
        button.setTitleColor(.Primary600, for: .selected)
        button.titleLabel?.font = .PretendardBold(size: 20)
        button.layer.borderColor = UIColor.Gray400.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 17
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    private lazy var answerButton2: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.White500, for: .normal)
        button.setBackgroundColor(.Primary400, for: .selected)
        button.setTitle("슈크림 붕어빵", for: .normal)
        button.setTitleColor(.Gray900, for: .normal)
        button.setTitleColor(.Primary600, for: .selected)
        button.titleLabel?.font = .PretendardBold(size: 20)
        button.layer.borderColor = UIColor.Gray400.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 17
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    lazy var nextButton: CustomButton = {
        let button = CustomButton(status: false, title: "결과 확인하기")
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

private extension QuizView {
    func setUI() {
        self.backgroundColor = .White500
    }
    
    func setAddTarget() {
       
    }
    
    func setLayout() {
        self.addSubviews(navigationBarView, balanceLabel, balanceSubLabel, backgroundView, nextButton)
        backgroundView.addSubviews(questionLabel, answerButton1, answerButton2)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
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
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 376 / 812)
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(26)
            $0.leading.equalToSuperview().inset(24)
        }
        
        answerButton1.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 136 / 812)
        }
    
        answerButton2.snp.makeConstraints {
            $0.top.equalTo(answerButton1.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 136 / 812)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
}
