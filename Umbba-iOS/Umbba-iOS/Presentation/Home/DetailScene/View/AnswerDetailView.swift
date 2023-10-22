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
    
    private let partnerQeustLabel: UILabel = {
        let label = UILabel()
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
    
    lazy var partnerAnswerContent: UILabel = {
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
        label.textColor = .Gray800
        label.text = I18N.Detail.pleaseAnswer
        label.font = .PretendardRegular(size: 16)
        label.textAlignment = .right
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
        button.setBackgroundColor(.UmbbaWhite, for: .normal)
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
        self.backgroundColor = .UmbbaWhite
    }
    
    func setAddTarget() {
        navigationBarView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
    }
    
    func setLayout() {
        self.addSubviews(navigationBarView, themeStackView, nextButton, homeButton, partnerQeustLabel, partnerAnswerView, myQuestLabel, myAnswerView)
        partnerAnswerView.addSubviews(partnerNameLabel, partnerAnswerContent)
        myAnswerView.addSubviews(myNameLabel, myAnswerContent)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        themeStackView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(9)
            $0.centerX.equalToSuperview()
        }
        
        partnerQeustLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(24)
            $0.top.equalTo(themeStackView.snp.bottom).offset(24)
        }
        
        partnerAnswerView.snp.makeConstraints {
            $0.top.equalTo(partnerQeustLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(22)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 174 / 812)
        }
        
        partnerNameLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(16)
        }
        
        partnerAnswerContent.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
        }
        
        myQuestLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(partnerAnswerView.snp.bottom).offset(16)
        }
        
        myAnswerView.snp.makeConstraints {
            $0.top.equalTo(myQuestLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(22)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 174 / 812)
        }
        
        myNameLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(16)
        }
        
        myAnswerContent.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        
        homeButton.snp.makeConstraints {
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
    
    @objc
    func homeButtonTapped() {
        homeDelegate?.homeButtonTapped()
    }
    
    @objc
    func handleTap(sender: UITapGestureRecognizer) {
        nextDelegate?.nextButtonTapped()
    }
}

extension AnswerDetailView {
    
    func applyTextBlur(to view: UIView, blurRadius: Float) {
        // 기존 텍스트를 숨김
        view.isHidden = true
        
        // 텍스트를 이미지로 렌더링
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let textImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // 이미지를 블러 처리
        if let textImage = textImage {
            if let inputImage = CIImage(image: textImage) {
                if let filter = CIFilter(name: "CIGaussianBlur") {
                    filter.setValue(inputImage, forKey: kCIInputImageKey)
                    filter.setValue(blurRadius, forKey: kCIInputRadiusKey)
                    
                    if let outputImage = filter.outputImage {
                        // 블러 처리된 이미지를 화면에 표시
                        let context = CIContext(options: nil)
                        if let cgImage = context.createCGImage(outputImage, from: inputImage.extent) {
                            let blurredImageView = UIImageView(image: UIImage(cgImage: cgImage))
                            blurredImageView.frame = view.frame
                            view.superview?.insertSubview(blurredImageView, belowSubview: view)
                        }
                    }
                }
            }
        }
    }
    
    func removeTextBlur(from view: UIView) {
        // 텍스트 블러 처리를 제거하고 텍스트를 다시 표시
        view.isHidden = false

        // 블러 처리된 이미지뷰를 찾아서 삭제
        for subview in view.superview?.subviews ?? [] {
            if subview is UIImageView {
                subview.removeFromSuperview()
            }
        }
    }
    
    func setTodayDataBind(model: TodayEntity) {
        if model.isMyAnswer {
            myAnswerContent.text = model.myAnswer
            myAnswerContent.textColor = .UmbbaBlack
            nextButton.isHidden = true
            homeButton.isHidden = false
            for gestureRecognizer in myAnswerView.gestureRecognizers ?? [] {
                myAnswerView.removeGestureRecognizer(gestureRecognizer)
            }
        } else {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
            myAnswerView.addGestureRecognizer(tapGesture)
        }
        
        if model.isOpponentAnswer {
            partnerAnswerContent.text = model.opponentAnswer
            partnerAnswerContent.textColor = .UmbbaBlack
        }
        
        if model.isOpponentAnswer && !model.isMyAnswer {
            partnerAnswerContent.text = model.opponentAnswer
            applyTextBlur(to: partnerAnswerContent, blurRadius: 12.0)
        }
        
        navigationBarView.cafe24Title = model.section
        numberLabel.text = "#\(model.index ?? 0)"
        themeLabel.text = model.topic
        partnerQeustLabel.text = model.opponentQuestion
        partnerNameLabel.text = model.opponentUsername
        myQuestLabel.text = model.myQuestion
        myNameLabel.text = model.myUsername
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
        partnerQeustLabel.text = model.opponentQuestion
        partnerNameLabel.text = model.opponentUsername
        myQuestLabel.text = model.myQuestion
        myNameLabel.text = model.myUsername
        myAnswerContent.text = model.myAnswer
        partnerAnswerContent.text = model.opponentAnswer
    }
}
