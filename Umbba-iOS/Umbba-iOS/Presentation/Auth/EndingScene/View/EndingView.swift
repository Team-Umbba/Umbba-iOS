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
    func surveyButtonTapped()
    func passButtonTapped()
}

final class EndingView: UIView {
    
    weak var endingDelegate: EndingDelegate?
    
    // MARK: - UI Components
    
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
    
    private let endingBackgroundImage = UIImageView(image: UIImage(resource: .imgGradation))
    
    private let endingLogoImage: UIImageView = {
        let image = UIImageView(image: UIImage(resource: .umbbaLogo))
        image.alpha = 0.75
        return image
    }()
    
    private let surveyTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Ending.surveyTitle
        label.textColor = .Gray900
        label.font = .PretendardRegular(size: 16)
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
    
    private lazy var surveyPassButton: UIButton = {
        let button = UIButton()
        button.setTitle(I18N.Ending.surveyPassButtonTitle, for: .normal)
        button.setTitleColor(.Gray900, for: .normal)
        button.titleLabel?.font = .PretendardRegular(size: 16)
        button.titleLabel?.setUnderlinePartFontChange(targetString: I18N.Ending.surveyPassButtonTitle, font: .PretendardRegular(size: 16))
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
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Extensions

private extension EndingView {
    
    func setUI() {
        backgroundColor = .Primary400
    }
    
    func setHierarchy() {
        endingBackgroundImage.addSubview(endingLogoImage)
        addSubviews(exitButton, endingTitle, endingSubTitle, endingBackgroundImage, surveyTitle, surveyButton, surveyPassButton)
    }
    
    func setAddTarget() {
        surveyButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        surveyPassButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setLayout() {
        exitButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 51 / 812)
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
        
        endingBackgroundImage.snp.makeConstraints {
            $0.top.equalTo(endingSubTitle.snp.bottom).offset(SizeLiterals.Screen.deviceRatio > 0.5 ? -30 : 2)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(SizeLiterals.Screen.screenWidth * 386 / 375)
        }
        
        endingLogoImage.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(SizeLiterals.Screen.screenWidth * 174 / 375)
        }
        
        surveyPassButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 68 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(56)
            $0.height.equalTo(19)
        }
        
        surveyButton.snp.makeConstraints {
            $0.bottom.equalTo(surveyPassButton.snp.top).offset(-28)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 56)
            $0.height.equalTo(60)
        }
        
        surveyTitle.snp.makeConstraints {
            $0.bottom.equalTo(surveyButton.snp.top).offset(-12)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        switch sender {
        case exitButton:
            endingDelegate?.exitButtonTapped()
        case surveyPassButton:
            endingDelegate?.passButtonTapped()
        case surveyButton:
            endingDelegate?.surveyButtonTapped()
        default:
            break
        }
    }
}
