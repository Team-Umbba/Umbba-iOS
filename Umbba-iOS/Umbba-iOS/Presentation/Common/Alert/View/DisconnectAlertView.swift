//
//  DisconnectAlert.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/15.
//

import UIKit

import SnapKit

final class DisconnectAlertView: UIView {
    
    weak var delegate: AlertDelegate?
    
    // MARK: - UI Components
    
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.Common.icn_exit, for: .normal)
        button.tintColor = .UmbbaBlack
        return button
    }()
    
    private let disconnectTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Alert.disconnectTitle
        label.font = .PretendardSemiBold(size: 20)
        label.textColor = .UmbbaBlack
        label.textAlignment = .center
        return label
    }()
    
    private let disconnectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Home.icn_disconnect
        return imageView
    }()
    
    private let discriptionLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Alert.disconnectDiscription
        label.font = .PretendardRegular(size: 16)
        label.textColor = .UmbbaBlack
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
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

private extension DisconnectAlertView {
    func setUI() {
        self.backgroundColor = .White500
        self.layer.cornerRadius = 16
    }
    
    func setAddTarget() {
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
    }
    
    func setLayout() {
        self.addSubviews(exitButton, disconnectTitle, disconnectImageView, discriptionLabel)
        
        exitButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.size.equalTo(48)
        }
        
        disconnectTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(56)
            $0.centerX.equalToSuperview()
        }
        
        disconnectImageView.snp.makeConstraints {
            $0.top.equalTo(disconnectTitle.snp.bottom).offset(56)
            $0.size.equalTo(SizeLiterals.Screen.screenWidth * 152 / 375)
            $0.centerX.equalToSuperview()
        }
        
        discriptionLabel.snp.makeConstraints {
            $0.top.equalTo(disconnectImageView.snp.bottom).offset(64)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - @objc Functions
  
    @objc func exitButtonTapped() {
        delegate?.alertDismissTapped()
    }
}
