//
//  LoginView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/05.
//

import UIKit

import SnapKit

final class LoginView: UIView {
    
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
        let button = CustomButton(status: false, title: I18N.Auth.appleButtonTitle)
        button.titleLabel?.textColor = .UmbbaWhite
        button.titleLabel?.font = .PretendardRegular(size: 16)
        button.layer.cornerRadius = 30
        return button
    }()
    
    lazy var loginKakaoButton: UIButton = {
        let button = CustomButton(status: false, title: I18N.Auth.kakaoButtonTitle)
        button.titleLabel?.textColor = .UmbbaWhite
        button.titleLabel?.font = .PretendardRegular(size: 16)
        button.layer.cornerRadius = 30
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
    
    func setHierarchy() {
        addSubviews(loginViewImage, loginLabel, loginAppleButton, loginKakaoButton)
    }
    
    func setLayout() {
        backgroundColor = .white
        
        loginViewImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(85)
            $0.leading.equalToSuperview().inset(24)
            $0.width.equalTo(86)
            $0.height.equalTo(22)
        }
        
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(loginViewImage.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(24)
        }
        
        loginAppleButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(116)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(319)
            $0.height.equalTo(60)
        }
        
        loginKakaoButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(44)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(319)
            $0.height.equalTo(60)
        }
    }

}
