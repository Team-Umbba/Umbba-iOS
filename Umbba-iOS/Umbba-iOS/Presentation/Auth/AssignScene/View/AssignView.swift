//
//  AssignView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/11.
//

import UIKit

import SnapKit
import SafariServices

protocol AssignDelegate: AnyObject {
    func presentURL(secton: Int)
    func nextButtonTapped()
}

final class AssignView: UIView {
    
    // MARK: - Properties
    
    weak var assignDelegate: AssignDelegate?
    weak var nextDelegate: NextButtonDelegate?

    // MARK: - UI Components
    
    private lazy var buttons = [assignEntireCheck, assignFirstCheck, assignSecondCheck, assignThirdCheck]
    private lazy var clickedButton = [false, false, false, false]
    
    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.Common.img_umbbaLogo
        return image
    }()
    
    private let logoTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Auth.logoTitle
        label.font = .Cafe24Regular(size: 20)
        label.textColor = .Primary500
        return label
    }()
    
    private let logoSubTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Auth.logoSubTitle
        label.font = .PretendardRegular(size: 12)
        label.textColor = .Primary500
        return label
    }()
    
    private let lineView: UIView = {
        let line = UIView()
        line.backgroundColor = .Gray400
        return line
    }()
    
    private let assignEntireTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Auth.assignEntireTitle
        label.font = .PretendardSemiBold(size: 16)
        label.textColor = .UmbbaBlack
        return label
    }()
    
    private let assignEntireSubTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Auth.assignEntireSubTitle
        label.numberOfLines = 0
        label.font = .PretendardRegular(size: 12)
        label.textColor = .Gray800
        return label
    }()
    
    private lazy var assignEntireCheck: UIButton = {
        let check = UIButton()
        check.setImage((ImageLiterals.NavigationBar.icn_check).withRenderingMode(.alwaysTemplate), for: .normal)
        check.imageView?.tintColor = .Gray800
        return check
    }()
    
    private let assignFirstTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Auth.assignFirstTitle
        label.font = .PretendardRegular(size: 12)
        label.textColor = .UmbbaBlack
        return label
    }()
    
    private let assignFirstSubTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Auth.assignFirstSubTitle
        label.numberOfLines = 0
        label.font = .PretendardRegular(size: 10)
        label.textColor = .Gray800
        return label
    }()
    
    private lazy var assignFirstCheck: UIButton = {
        let check = UIButton()
        check.setImage((ImageLiterals.Auth.icn_check_circle).withRenderingMode(.alwaysTemplate), for: .normal)
        check.tintColor = .Gray800
        return check
    }()
    
    private lazy var assignSecondTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Auth.assignSecondTitle
        label.font = .PretendardRegular(size: 12)
        label.setUnderlinePartFontChange(targetString: "서비스 이용약관", font: .PretendardBold(size: 12))
        label.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(secondTitleLabelTapped(_: )))
        label.addGestureRecognizer(recognizer)
        label.textColor = .UmbbaBlack
        return label
    }()
    
    private lazy var assignSecondCheck: UIButton = {
        let check = UIButton()
        check.setImage((ImageLiterals.Auth.icn_check_circle).withRenderingMode(.alwaysTemplate), for: .normal)
        check.tintColor = .Gray800
        return check
    }()
    
    private lazy var assignThirdTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Auth.assignThirdTitle
        label.font = .PretendardRegular(size: 12)
        label.setUnderlinePartFontChange(targetString: "개인정보 수집 및 이용", font: .PretendardBold(size: 12))
        label.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(thirdTitleLabelTapped(_: )))
        label.addGestureRecognizer(recognizer)
        label.textColor = .UmbbaBlack
        return label
    }()
    
    private let assignThirdSubTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Auth.assignThirdSubTitle
        label.numberOfLines = 0
        label.font = .PretendardRegular(size: 10)
        label.textColor = .Gray800
        return label
    }()
    
    private lazy var assignThirdCheck: UIButton = {
        let check = UIButton()
        check.setImage((ImageLiterals.Auth.icn_check_circle).withRenderingMode(.alwaysTemplate), for: .normal)
        check.tintColor = .Gray800
        return check
    }()
    
    private let nextButton: UIButton = {
        let button = CustomButton(status: false, title: I18N.Auth.assignNextButtonTitle)
        button.setBackgroundColor(.Gray400, for: .disabled)
        button.setTitleColor(.White500, for: .disabled)
        button.setBackgroundColor(.White500, for: .normal)
        button.setTitleColor(.Primary500, for: .normal)
        button.isEnabled = false
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
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Extensions

extension AssignView {
    
    func setUI() {
        backgroundColor = .White500
    }
    
    func setHierarchy() {
        addSubviews(logoImage, logoTitle, logoSubTitle, lineView,
                    assignEntireTitle, assignEntireSubTitle, assignEntireCheck,
                    assignFirstTitle, assignFirstSubTitle, assignFirstCheck,
                    assignSecondTitle, assignSecondCheck,
                    assignThirdTitle, assignThirdSubTitle, assignThirdCheck, nextButton)
    }
    
    func setLayout() {
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(97)
            $0.width.equalTo(67)
            $0.height.equalTo(60)
        }
        
        logoTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoImage.snp.bottom).offset(2)
        }
        
        logoSubTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoTitle.snp.bottom).offset(12)
        }
        
        assignEntireTitle.snp.makeConstraints {
            $0.bottom.equalTo(assignEntireSubTitle.snp.top).offset(-14)
            $0.leading.equalToSuperview().inset(36)
        }
        
        assignEntireSubTitle.snp.makeConstraints {
            $0.bottom.equalTo(assignFirstTitle.snp.top).offset(-14)
            $0.leading.equalTo(assignEntireTitle.snp.leading)
            $0.trailing.equalTo(assignEntireCheck.snp.leading).offset(13)
        }
        
        assignEntireCheck.snp.makeConstraints {
            $0.centerY.equalTo(assignEntireTitle)
            $0.trailing.equalToSuperview().inset(36)
            $0.width.height.equalTo(48)
        }
        
        assignFirstTitle.snp.makeConstraints {
            $0.bottom.equalTo(assignFirstSubTitle.snp.top).offset(-9)
            $0.leading.equalTo(assignEntireTitle.snp.leading)
        }
        
        assignFirstSubTitle.snp.makeConstraints {
            $0.bottom.equalTo(assignSecondTitle.snp.top).offset(-29)
            $0.leading.equalTo(assignFirstTitle.snp.leading)
            $0.trailing.equalTo(assignFirstCheck.snp.leading).offset(6)
        }
        
        assignFirstCheck.snp.makeConstraints {
            $0.centerY.equalTo(assignFirstTitle)
            $0.trailing.equalTo(assignEntireCheck.snp.trailing)
            $0.width.height.equalTo(48)
        }
        
        assignSecondTitle.snp.makeConstraints {
            $0.bottom.equalTo(assignThirdTitle.snp.top).offset(-33)
            $0.leading.equalTo(assignFirstTitle.snp.leading)
        }
        
        assignSecondCheck.snp.makeConstraints {
            $0.centerY.equalTo(assignSecondTitle)
            $0.trailing.equalTo(assignFirstCheck.snp.trailing)
        }
        
        assignThirdTitle.snp.makeConstraints {
            $0.bottom.equalTo(assignThirdSubTitle.snp.top).offset(-8)
            $0.leading.equalTo(assignSecondTitle.snp.leading)
        }
        
        assignThirdCheck.snp.makeConstraints {
            $0.centerY.equalTo(assignThirdTitle)
            $0.trailing.equalTo(assignSecondCheck.snp.trailing)
            $0.width.height.equalTo(48)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        
        if SizeLiterals.Screen.deviceRatio > 0.5 {
            assignThirdSubTitle.snp.makeConstraints {
                $0.bottom.equalTo(nextButton.snp.top).offset(-30)
                $0.leading.equalTo(assignThirdTitle.snp.leading)
                $0.trailing.equalTo(assignThirdCheck.snp.leading).offset(6)
            }
            
            lineView.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(logoSubTitle.snp.bottom).offset(30)
                $0.width.equalTo(SizeLiterals.Screen.screenWidth * 300 / 375)
                $0.height.equalTo(1)
            }
        } else {
            assignThirdSubTitle.snp.makeConstraints {
                $0.bottom.equalTo(nextButton.snp.top).offset(-130)
                $0.leading.equalTo(assignThirdTitle.snp.leading)
                $0.trailing.equalTo(assignThirdCheck.snp.leading).offset(6)
            }
            
            lineView.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(logoSubTitle.snp.bottom).offset(60)
                $0.width.equalTo(SizeLiterals.Screen.screenWidth * 300 / 375)
                $0.height.equalTo(1)
            }
        }
    }
    
    private func setAddTarget() {
        assignEntireCheck.addTarget(self, action: #selector(clickedEntireCheck), for: .touchUpInside)
        assignFirstCheck.addTarget(self, action: #selector(clickedFirstCheck), for: .touchUpInside)
        assignSecondCheck.addTarget(self, action: #selector(clickedSecondCheck), for: .touchUpInside)
        assignThirdCheck.addTarget(self, action: #selector(clickedThirdCheck), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    func checkAll() {
        if clickedButton[1] && clickedButton[2] && clickedButton[3] {
            assignEntireCheck.imageView?.tintColor = .Primary600
            clickedButton[0] = true
            nextButton.isEnabled = true
            nextButton.layer.borderColor = UIColor.Primary500.cgColor
            nextButton.layer.borderWidth = 2
        } else {
            assignEntireCheck.imageView?.tintColor = .Gray800
            clickedButton[0] = false
            nextButton.isEnabled = false
            nextButton.layer.borderColor = UIColor.Gray800.cgColor
            nextButton.layer.borderWidth = 0
        }
    }
    
    func updateArray(section: Int) {
        if clickedButton[section] {
            clickedButton[section] = false
            buttons[section].imageView?.tintColor = .Gray800
        } else {
            clickedButton[section] = true
            buttons[section].imageView?.tintColor = .Primary600
        }
    }
    
    func updateEntire() {
        if clickedButton[0] {
            for id in 0...3 {
                updateArray(section: id)
            }
        } else {
            updateArray(section: 0)
            for id in 1...3 {
                if clickedButton[id] {
                    continue
                } else {
                    updateArray(section: id)
                }
            }
        }
    }

    func updateNextButton() {
        if nextButton.isEnabled {
            nextButton.isEnabled = false
            nextButton.layer.borderColor = UIColor.Gray400.cgColor
            nextButton.layer.borderWidth = 0
        } else {
            nextButton.isEnabled = true
            nextButton.layer.borderColor = UIColor.Primary500.cgColor
            nextButton.layer.borderWidth = 2
        }
    }
    
    @objc
    func clickedEntireCheck() {
        updateEntire()
        updateNextButton()
    }

    @objc
    func clickedFirstCheck() {
        updateArray(section: 1)
        checkAll()
    }
    
    @objc
    func clickedSecondCheck() {
        updateArray(section: 2)
        checkAll()
    }
    
    @objc
    func clickedThirdCheck() {
        updateArray(section: 3)
        checkAll()
    }
    
    @objc
    func secondTitleLabelTapped(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: assignSecondTitle)
        if let servicRuleRect = assignSecondTitle.boundingRectForCharacterRange(subText: "서비스 이용약관"),
           servicRuleRect.contains(point) {
            presentURL(section: 1)
        }
    }
    
    @objc
    func thirdTitleLabelTapped(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: assignThirdTitle)
        if let personalInfoRect = assignThirdTitle.boundingRectForCharacterRange(subText: "개인정보 수집 및 이용"),
           personalInfoRect.contains(point) {
            presentURL(section: 2)
        }
    }
    
    @objc
    func presentURL(section: Int) {
        assignDelegate?.presentURL(secton: section)
    }
    
    @objc
    func nextButtonTapped() {
        nextDelegate?.nextButtonTapped()
    }
}
