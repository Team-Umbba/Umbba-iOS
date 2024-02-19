//
//  EndingView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/08/25.
//

import UIKit

import SnapKit

protocol EndingDelegate: AnyObject {
    func exitButtonTapped()
    func continueButtonTapped()
    func surveyButtonTapped()
}

final class EndingView: UIView {
    
    weak var endingDelegate: EndingDelegate?
    
    // MARK: - UI Components
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.GradientHigh.withAlphaComponent(0.38).cgColor, UIColor.GradientHigh.withAlphaComponent(0).cgColor]
        gradient.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 217 / 812 * SizeLiterals.Screen.screenHeight)
        return gradient
    }()
    
    private let endingImageView: UIImageView = {
        let image = UIImageView()
        image.image = SizeLiterals.Screen.deviceRatio > 0.5 ? ImageLiterals.Ending.SE_ending_img : ImageLiterals.Ending.ending_img
        return image
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.Common.icn_exit, for: .normal)
        button.tintColor = .Gray900
        return button
    }()
    
    private let endingTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Ending.endingTitle
        label.textColor = .UmbbaBlack
        label.font = .PretendardSemiBold(size: 24)
        return label
    }()
    
    private let endingSubTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Ending.endingSubTitle
        label.textColor = .UmbbaBlack
        label.font = .PretendardRegular(size: 16)
        return label
    }()
    
    private let continueTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Ending.continueTitle
        label.textColor = .UmbbaBlack
        label.font = .PretendardRegular(size: 12)
        return label
    }()
    
    private lazy var continueButton: CustomButton = {
        let button = CustomButton(status: true, title: I18N.Home.questionButtonTitle)
        button.setBackgroundColor(.White500, for: .normal)
        button.setTitle(I18N.Ending.continueButtonTitle, for: .normal)
        button.setTitleColor(.Primary500, for: .normal)
        button.layer.borderColor = UIColor.Primary500.cgColor
        button.layer.borderWidth = 2
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    private let surveyTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Ending.surveyTitle
        label.textColor = .UmbbaBlack
        label.font = .PretendardRegular(size: 12)
        return label
    }()
    
    private lazy var surveyButton: CustomButton = {
        let button = CustomButton(status: true, title: I18N.Home.questionButtonTitle)
        button.setTitle(I18N.Ending.surveyButtonTitle, for: .normal)
        button.setTitleColor(.White500, for: .normal)
        button.setBackgroundColor(.Primary500, for: .normal)
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        setGradient()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Extensions

private extension EndingView {
    func setUI() {
        backgroundColor = .White500
    }
    
    func setGradient() {
        layer.addSublayer(gradientLayer)
    }
    
    func setHierarchy() {
        addSubviews(exitButton, endingTitle, endingSubTitle, endingImageView, continueTitle, continueButton, surveyTitle, surveyButton)
    }
    
    func setAddTarget() {
        surveyButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setLayout() {
        exitButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(6)
            $0.leading.equalToSuperview().inset(8)
            $0.size.equalTo(48)
        }
        
        endingTitle.snp.makeConstraints {
            $0.top.equalTo(exitButton.snp.bottom).offset(18)
            $0.leading.equalToSuperview().inset(28)
        }
        
        endingSubTitle.snp.makeConstraints {
            $0.top.equalTo(endingTitle.snp.bottom).offset(12)
            $0.leading.equalTo(endingTitle.snp.leading)
        }
        
        endingImageView.snp.makeConstraints {
            $0.top.equalTo(endingSubTitle.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 81 / 812)
            $0.leading.trailing.equalToSuperview()
        }
        
        surveyButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 56)
            $0.height.equalTo(60)
        }
        
        surveyTitle.snp.makeConstraints {
            $0.bottom.equalTo(surveyButton.snp.top).offset(-12)
            $0.centerX.equalToSuperview()
        }
        
        continueButton.snp.makeConstraints {
            $0.bottom.equalTo(surveyTitle.snp.top).offset(-16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 56)
            $0.height.equalTo(60)
        }
        
        continueTitle.snp.makeConstraints {
            $0.bottom.equalTo(continueButton.snp.top).offset(-12)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        switch sender {
        case exitButton:
            endingDelegate?.exitButtonTapped()
        case continueButton:
            endingDelegate?.continueButtonTapped()
        case surveyButton:
            endingDelegate?.surveyButtonTapped()
        default:
            break
        }
    }
}
