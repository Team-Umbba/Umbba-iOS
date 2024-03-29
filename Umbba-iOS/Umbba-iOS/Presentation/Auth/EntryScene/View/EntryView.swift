//
//  EntryView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/05.
//

import UIKit

import SnapKit

protocol EntryDelegate: AnyObject {
    func entryButtonTapped()
    func inviteButtonTapped()
}

final class EntryView: UIView {
    
    // MARK: - Properties
    
    weak var entryDelegate: EntryDelegate?
    
    // MARK: - UI Components
    
    private let entryBackgroundImage: UIImageView = {
        let backgroundimage = UIImageView()
        backgroundimage.contentMode = .scaleAspectFill
        if SizeLiterals.Screen.deviceRatio > 0.5 {
            backgroundimage.image = ImageLiterals.Auth.SE_start
        } else {
            backgroundimage.image = ImageLiterals.Auth.img_start
        }
        return backgroundimage
    }()
    
    private let loginImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.Common.img_umbbaLogo
        return image
    }()
    
    private let loginTitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Auth.logoTitle
        label.font = .Cafe24Regular(size: 20)
        label.textColor = .Primary500
        return label
    }()
    
    private let loginSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Auth.logoSubTitle
        label.font = .PretendardRegular(size: 12)
        label.textColor = .Primary500
        return label
    }()
    
    lazy var entryButton: UIButton = {
        let button = CustomButton(status: true, title: I18N.Auth.entryButtonTitle)
        return button
    }()
    
    private let dividingText: UILabel = {
        let label = UILabel()
        label.text = I18N.Auth.dividingText
        label.textColor = .Gray800
        label.font = .PretendardRegular(size: 16)
        return label
    }()
    
    private let inviteText: UILabel = {
        let label = UILabel()
        label.text = I18N.Auth.inviteText
        label.textColor = .Gray800
        label.font = .PretendardRegular(size: 16)
        return label
    }()
    
    private lazy var inviteButton: CustomButton = {
        let button = CustomButton(status: true, title: I18N.Home.questionButtonTitle)
        button.setBackgroundColor(.White500, for: .normal)
        button.setTitle(I18N.Auth.inviteButtonTitle, for: .normal)
        button.setTitleColor(.Primary500, for: .normal)
        button.layer.borderColor = UIColor.Primary500.cgColor
        button.layer.borderWidth = 2
        button.adjustsImageWhenHighlighted = false

        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = .White500
        button.configuration = config
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension EntryView {
    func setUI() {
        backgroundColor = .White500
    }
    
    func setHierarchy() {
        addSubviews(entryBackgroundImage, loginImage, loginTitleLabel, loginSubTitleLabel, entryButton, dividingText, inviteText, inviteButton)
    }
    
    func setLayout() {
        entryBackgroundImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaInsets)
        }
        
        loginImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(97)
            $0.width.equalTo(67)
            $0.height.equalTo(60)
        }
        
        loginTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginImage.snp.bottom).offset(2)
        }
        
        loginSubTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginTitleLabel.snp.bottom).offset(12)
        }
        
        entryButton.snp.makeConstraints {
            $0.bottom.equalTo(dividingText.snp.top).offset(-12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        
        dividingText.snp.makeConstraints {
            $0.bottom.equalTo(inviteText.snp.top).offset(-12)
            $0.centerX.equalToSuperview()
        }
        
        inviteText.snp.makeConstraints {
            $0.bottom.equalTo(inviteButton.snp.top).offset(-12)
            $0.centerX.equalToSuperview()
        }
        
        inviteButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
    func setAddTarget() {
        entryButton.addTarget(self, action: #selector(entryButtonTapped), for: .touchUpInside)
        inviteButton.addTarget(self, action: #selector(inviteButtonTapped), for: .touchUpInside)
    }
    
    func updateUI() {
        if SizeLiterals.Screen.deviceRatio > 0.5 {
            entryBackgroundImage.image = ImageLiterals.Auth.SE_start
        }
    }
    
    @objc
    func entryButtonTapped() {
        entryDelegate?.entryButtonTapped()
    }
    
    @objc
    func inviteButtonTapped() {
        entryDelegate?.inviteButtonTapped()
    }
}
