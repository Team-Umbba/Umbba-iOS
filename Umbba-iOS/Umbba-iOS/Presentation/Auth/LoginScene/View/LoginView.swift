//
//  LoginView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/05.
//

import UIKit

import SnapKit

final class LoginView: UIView {
    
    let screenSize = UIScreen.main.bounds.width
    
    private lazy var loginViewImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Auth.loginTitle
        label.textColor = .UmbbaBlack
        label.font = .PretendardRegular(size: 24)
        return label
    }()
    
    lazy var loginAppleButton: UIButton = {
        var config = UIButton.Configuration.plain()
        var title = AttributedString.init(I18N.Auth.appleButtonTitle)
        title.font = .PretendardBold(size: 16)
        title.foregroundColor = .UmbbaWhite
        config.attributedTitle = title
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24)
        let image = UIImage(systemName: "apple.logo", withConfiguration: imageConfig)
        config.image = image
        config.imagePadding = 72 / 375 * screenSize
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        
        let button = UIButton(configuration: config)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 30
        button.contentHorizontalAlignment = .left
        
        return button
    }()
    
    lazy var loginKakaoButton: UIButton = {
        var config = UIButton.Configuration.plain()
        var title = AttributedString.init(I18N.Auth.kakaoButtonTitle)
        title.font = .PretendardBold(size: 16)
        title.foregroundColor = .UmbbaWhite
        config.attributedTitle = title
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24)
        let image = UIImage(systemName: "message.fill", withConfiguration: imageConfig)
        config.image = image
        config.imagePadding = 72 / 375 * screenSize
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        
        let button = UIButton(configuration: config)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 30
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // MARK: - UI Components
        setUI()
        
        // MARK: - addsubView
        setHierarchy()
        
        // MARK: - autolayout설정
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LoginView {
    
    func setUI() {
        backgroundColor = .white
    }
    
    func setHierarchy() {
        addSubviews(loginViewImage, loginLabel, loginAppleButton, loginKakaoButton)
    }
    
    func setLayout() {
        
        loginViewImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(85)
            $0.leading.equalToSuperview().inset(24)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 86 / 375)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 22 / 375)
        }
        
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(loginViewImage.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(24)
        }
        
        loginAppleButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(116)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        
        loginKakaoButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(44)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
}
