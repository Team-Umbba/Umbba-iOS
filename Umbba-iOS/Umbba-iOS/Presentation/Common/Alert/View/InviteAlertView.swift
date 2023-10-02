//
//  InviteAlertView.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/11.
//

import UIKit

import SnapKit

final class InviteAlertView: UIView {
    
    weak var delegate: AlertDelegate?
    
    // MARK: - Properties
    
    var inviteUsername: String?
    var installURL: String?
    
    // MARK: - UI Components
    
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.Common.icn_exit, for: .normal)
        button.tintColor = .UmbbaBlack
        return button
    }()
    
    private let inviteTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Alert.inviteTitle
        label.font = .PretendardSemiBold(size: 20)
        label.textColor = .UmbbaBlack
        label.numberOfLines = 2
        return label
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Common.img_umbbaLogo
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var copyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .UmbbaWhite
        button.setTitleColor(.Primary500, for: .normal)
        button.setTitle(I18N.Alert.copyButtonTitle, for: .normal)
        button.titleLabel?.font = .PretendardSemiBold(size: 16)
        button.layer.borderColor = UIColor.Primary500.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 17.5
        return button
    }()
    
    let inviteCode: UILabel = {
        let label = UILabel()
        label.text = I18N.Alert.inviteCode
        label.font = .PretendardSemiBold(size: 20)
        label.textColor = .UmbbaBlack
        return label
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .Primary500
        button.setTitleColor(.UmbbaWhite, for: .normal)
        button.setTitle(I18N.Alert.shareButtonTitle, for: .normal)
        button.titleLabel?.font = .PretendardSemiBold(size: 16)
        button.layer.cornerRadius = 24
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setAddTarget()
        setLayout()
        enableCopyOnTouch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension InviteAlertView {
    func setUI() {
        self.backgroundColor = .UmbbaWhite
        self.layer.cornerRadius = 16
    }
    
    func setAddTarget() {
        copyButton.addTarget(self, action: #selector(copyButtonTapped(sender:)), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
    }
    
    func setLayout() {
        self.addSubviews(exitButton, inviteTitle, logoImageView, copyButton, inviteCode, shareButton)
        
        exitButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.size.equalTo(48)
        }
        
        inviteTitle.snp.makeConstraints {
            $0.top.equalTo(exitButton.snp.bottom)
            $0.leading.equalToSuperview().inset(28)
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(inviteTitle.snp.bottom).offset(19)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 173 / 375)
            $0.centerX.equalToSuperview()
        }
        
        copyButton.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(8)
            $0.height.equalTo(35)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 119 / 375)
        }
        
        inviteCode.snp.makeConstraints {
            $0.top.equalTo(copyButton.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        shareButton.snp.makeConstraints {
            $0.top.equalTo(inviteCode.snp.bottom).offset(42)
            $0.height.equalTo(48)
            $0.bottom.equalToSuperview().inset(32)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 268 / 375)
        }
    }
    
    func enableCopyOnTouch() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(copyButtonTapped(sender:)))
        inviteCode.isUserInteractionEnabled = true
        inviteCode.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - @objc Functions
    
    @objc func copyButtonTapped(sender: UITapGestureRecognizer) {
        if let inviteCode = inviteCode.text {
            delegate?.copyButtonTapped(inviteCode: inviteCode)
        }
    }
    
    @objc func exitButtonTapped() {
        delegate?.alertDismissTapped()
    }
    
    @objc func shareButtonTapped() {
        delegate?.colorButtonTapped()
    }
}
