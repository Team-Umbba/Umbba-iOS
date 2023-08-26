//
//  EndingView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/08/25.
//

import UIKit

import SnapKit

protocol EndingDelegate: AnyObject {
    func surveyButtonTapped()
    func endButtonTapped()
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
        button.tintColor = .UmbbaBlack
        return button
    }()
    
    private let endingTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Ending.endingTitle
        label.textColor = .UmbbaBlack
        label.font = .PretendardSemiBold(size: 24)
        label.numberOfLines = 2
        return label
    }()
    
    private let surveyTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Ending.surveyTitle
        label.textColor = .UmbbaBlack
        label.font = .PretendardRegular(size: 20)
        return label
    }()
    
    private let surveySubTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Ending.surveySubTitle
        label.textColor = .UmbbaBlack
        label.font = .PretendardRegular(size: 10)
        return label
    }()
    
    private lazy var surveyButton: CustomButton = {
        let button = CustomButton(status: true, title: I18N.Home.questionButtonTitle)
        button.setTitle(I18N.Ending.surveyButtonTitle, for: .normal)
        button.setTitleColor(.UmbbaWhite, for: .normal)
        button.setBackgroundColor(.Primary500, for: .normal)
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    private let dividingText: UILabel = {
        let label = UILabel()
        label.text = I18N.Ending.dividingText
        label.textColor = .Gray800
        label.font = .PretendardRegular(size: 16)
        return label
    }()
    
    private let endTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Ending.endTitle
        label.textColor = .UmbbaBlack
        label.font = .PretendardRegular(size: 20)
        return label
    }()
    
    private let endSubTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Ending.endSubTitle
        label.textColor = .UmbbaBlack
        label.font = .PretendardRegular(size: 10)
        return label
    }()
    
    private lazy var endButton: CustomButton = {
        let button = CustomButton(status: true, title: I18N.Home.questionButtonTitle)
        button.setBackgroundColor(.UmbbaWhite, for: .normal)
        button.setTitle(I18N.Ending.endButtonTitle, for: .normal)
        button.setTitleColor(.Primary500, for: .normal)
        button.layer.borderColor = UIColor.Primary500.cgColor
        button.layer.borderWidth = 2
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

extension EndingView {
    func setUI() {
        backgroundColor = .UmbbaWhite
    }
    
    func setGradient() {
        layer.addSublayer(gradientLayer)
    }
    
    func setHierarchy() {
        addSubviews(endingImageView, exitButton, endingTitle,
                    surveyTitle, surveySubTitle, surveyButton, dividingText,
                    endTitle, endSubTitle, endButton)
    }
    
    func setAddTarget() {
        surveyButton.addTarget(self, action: #selector(surveyTapped), for: .touchUpInside)
        endButton.addTarget(self, action: #selector(endTapped), for: .touchUpInside)
    }
    
    func setLayout() {
        endingImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        exitButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(7)
            $0.trailing.equalToSuperview().offset(-15)
            $0.size.equalTo(48)
        }
        
        endingTitle.snp.makeConstraints {
            $0.top.equalTo(exitButton.snp.bottom).offset(17)
            $0.leading.equalToSuperview().inset(28)
        }
        
        surveyTitle.snp.makeConstraints {
            $0.top.equalTo(endingTitle.snp.bottom).offset(42)
            $0.leading.equalToSuperview().inset(28)
        }
        
        surveySubTitle.snp.makeConstraints {
            $0.top.equalTo(surveyTitle.snp.bottom).offset(6)
            $0.leading.equalTo(surveyTitle.snp.leading)
        }
        
        surveyButton.snp.makeConstraints {
            $0.top.equalTo(surveySubTitle.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(60)
        }
        
        dividingText.snp.makeConstraints {
            $0.top.equalTo(surveyButton.snp.bottom).offset(28)
            $0.centerX.equalToSuperview().inset(28)
        }
        
        endTitle.snp.makeConstraints {
            $0.top.equalTo(dividingText.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(28)
        }
        
        endSubTitle.snp.makeConstraints {
            $0.top.equalTo(endTitle.snp.bottom).offset(6)
            $0.leading.equalTo(endTitle.snp.leading)
        }
        
        endButton.snp.makeConstraints {
            $0.top.equalTo(endSubTitle.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(60)
        }
    }
    
    @objc
    func surveyTapped() {
        endingDelegate?.surveyButtonTapped()
    }

    @objc
    func endTapped() {
        endingDelegate?.endButtonTapped()
    }
}
