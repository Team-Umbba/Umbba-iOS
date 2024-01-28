//
//  CustomNavigationBar.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/10.
//

import UIKit

final class CustomNavigationBar: UIView {
    
    public var pretendardTitle: String? {
        get { pretendardtTitleLabel.text }
        set { pretendardtTitleLabel.text = newValue }
    }
    
    public var cafe24Title: String? {
        get { cafe24TitleLabel.text }
        set { cafe24TitleLabel.text = newValue }
    }
    
    public var isLeftButtonIncluded: Bool {
        get { !leftButton.isHidden }
        set { leftButton.isHidden = !newValue }
    }
    
    public var isRightButtonIncluded: Bool {
        get { !rightButton.isHidden }
        set { rightButton.isHidden = !newValue }
    }
    
    public var isCameraButtonIncluded: Bool {
        get { !cameraButton.isHidden }
        set { cameraButton.isHidden = !newValue }
    }
    
    public var isTitleViewIncluded: Bool {
        get { !titleView.isHidden }
        set { titleView.isHidden = !newValue }
    }
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.NavigationBar.icn_back, for: .normal)
        button.tintColor = .UmbbaBlack
        button.isHidden = true
        return button
    }()
    
    private let pretendardtTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.font = .PretendardRegular(size: 16)
        return label
    }()
    
    private let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .Primary500
        view.layer.cornerRadius = 16
        view.isHidden = true
        return view
    }()
    
    private let cafe24TitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .White500
        label.font = .Cafe24Regular(size: 16)
        return label
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.NavigationBar.icn_check, for: .normal)
        button.tintColor = .UmbbaBlack
        button.isHidden = true
        return button
    }()
    
    lazy var cameraButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .icCamera), for: .normal)
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomNavigationBar {
    func setUI() {
        self.backgroundColor = .White500
    }
    
    func setLayout() {
        self.addSubviews(leftButton, pretendardtTitleLabel, titleView, rightButton, cameraButton)
        titleView.addSubviews(cafe24TitleLabel)
        
        self.snp.makeConstraints {
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 60 / 812)
        }
        
        leftButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(6)
            $0.size.equalTo(48)
        }
        
        pretendardtTitleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        titleView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(32)
        }
        
        cafe24TitleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(49)
        }
        
        rightButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(6)
            $0.size.equalTo(48)
        }
        
        cameraButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(6)
            $0.size.equalTo(48)
        }
    }
}
