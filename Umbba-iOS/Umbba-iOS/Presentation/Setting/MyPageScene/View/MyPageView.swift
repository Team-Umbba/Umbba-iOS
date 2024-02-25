//
//  MyPageView.swift
//  Umbba-iOS
//
//  Created by 최영린 on 1/30/24.
//

import UIKit

import SnapKit

// MARK: - Protocols

protocol SettingButtonDelegate: AnyObject {
    func settingButtonTapped()
}

final class MyPageView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: SettingButtonDelegate?
    
    // MARK: - UI Components
    
    private let navigationBarView: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.isSettingButtonIncluded = true
        return view
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .White500
        view.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        return view
    }()
    
    private let parentMeView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray800
        view.layer.cornerRadius = 7
        view.isHidden = true
        return view
    }()
    
    private let parentMeLabel: UILabel = {
        let label = UILabel()
        label.text = "나"
        label.textColor = .White400
        label.font = .PretendardBold(size: 12)
        return label
    }()
    
    private let parentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray800
        label.font = .PretendardRegular(size: 16)
        return label
    }()
    
    private let parentNicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.font = .PretendardBold(size: 24)
        return label
    }()
    
    private let lineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.MyPage.line_img
        return imageView
    }()
    
    private let childMeView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray800
        view.layer.cornerRadius = 7
        view.isHidden = true
        return view
    }()
    
    private let childMeLabel: UILabel = {
        let label = UILabel()
        label.text = "나"
        label.textColor = .White400
        label.font = .PretendardBold(size: 12)
        return label
    }()
    
    private let childLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray800
        label.font = .PretendardRegular(size: 16)
        return label
    }()
    
    private let childNicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.font = .PretendardBold(size: 24)
        return label
    }()
    
    private let topicLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.font = .Cafe24Regular(size: 16)
        return label
    }()
    
    private let dayTitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.MyPage.dayTitle
        label.textColor = .UmbbaBlack
        label.font = .PretendardBold(size: 16)
        return label
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.font = .PretendardRegular(size: 16)
        return label
    }()
    
    private lazy var dayStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.addArrangedSubviews(dayTitleLabel, dayLabel)
        return stackView
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray800
        return view
    }()
    
    private let answerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.MyPage.answerTitle
        label.textColor = .UmbbaBlack
        label.font = .PretendardBold(size: 16)
        return label
    }()
    
    private let answerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.font = .PretendardRegular(size: 16)
        return label
    }()
    
    private lazy var answerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.addArrangedSubviews(answerTitleLabel, answerLabel)
        return stackView
    }()
    
    private let topicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.MyPage.topic_img1
        return imageView
    }()
    
    let relationView: UIView = {
        let view = UIView()
        view.backgroundColor = .White500
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.Gray400.cgColor
        return view
    }()
    
    private let relationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.MyPage.relationTitle
        label.textColor = .UmbbaBlack
        label.font = .PretendardBold(size: 20)
        return label
    }()
    
    private let relationDetailLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.MyPage.relationDetail
        label.textColor = .Gray900
        label.font = .PretendardRegular(size: 16)
        return label
    }()
    
    private let relationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.MyPage.relation_img
        return imageView
    }()
    
    let albumView: UIView = {
        let view = UIView()
        view.backgroundColor = .White500
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.Gray400.cgColor
        return view
    }()
    
    private let albumTitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.MyPage.albumTitle
        label.textColor = .UmbbaBlack
        label.font = .PretendardBold(size: 20)
        return label
    }()
    
    private let albumDetailLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.MyPage.albumDetail
        label.textColor = .Gray900
        label.font = .PretendardRegular(size: 16)
        return label
    }()
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.MyPage.camera_img
        return imageView
    }()
    
    private lazy var viewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        stackView.addArrangedSubviews(relationView, albumView)
        return stackView
    }()
    
    private let copyrightLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.MyPage.copyright
        label.textColor = .Gray800
        label.font = .PretendardRegular(size: 10)
        return label
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension MyPageView {
    func setUI() {
        self.backgroundColor = .Gray300
    }
    
    func setAddTarget() {
        navigationBarView.settingButton.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
    }
    
    func setLayout() {
        self.addSubviews(backgroundView, navigationBarView, viewStackView, copyrightLabel)
        backgroundView.addSubviews(parentLabel, parentNicknameLabel, parentMeView, childMeView, childLabel, childNicknameLabel,
                                   lineImageView, topicLabel, dayStackView, lineView, answerStackView, topicImageView)
        parentMeView.addSubview(parentMeLabel)
        childMeView.addSubview(childMeLabel)
        relationView.addSubviews(relationTitleLabel, relationDetailLabel, relationImageView)
        albumView.addSubviews(albumTitleLabel, albumDetailLabel, albumImageView)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 357 / 812)
        }
        
        lineImageView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(60)
            $0.height.equalTo(50)
        }
        
        parentLabel.snp.makeConstraints {
            $0.top.equalTo(lineImageView.snp.top)
            $0.trailing.equalTo(lineImageView.snp.leading).offset(-10)
        }
        
        parentNicknameLabel.snp.makeConstraints {
            $0.top.equalTo(parentLabel.snp.bottom).offset(2)
            $0.trailing.equalTo(parentLabel.snp.trailing)
        }
        
        parentMeView.snp.makeConstraints {
            $0.width.equalTo(23)
            $0.height.equalTo(14)
            $0.centerY.equalTo(parentLabel.snp.centerY)
            $0.trailing.equalTo(parentLabel.snp.leading).offset(-4)
        }
        
        parentMeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
      
        childMeView.snp.makeConstraints {
            $0.width.equalTo(23)
            $0.height.equalTo(14)
            $0.centerY.equalTo(childLabel.snp.centerY)
            $0.leading.equalTo(lineImageView.snp.trailing).offset(10)
        }
        
        childMeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        childLabel.snp.makeConstraints {
            $0.top.equalTo(lineImageView.snp.top)
            $0.leading.equalTo(childMeView.snp.trailing).offset(6)
        }
        
        childNicknameLabel.snp.makeConstraints {
            $0.top.equalTo(childLabel.snp.bottom).offset(2)
            $0.leading.equalTo(lineImageView.snp.trailing).offset(10)
        }
        
        topicLabel.snp.makeConstraints {
            $0.bottom.equalTo(dayStackView.snp.top).offset(-24)
            $0.centerX.equalToSuperview()
        }
        
        lineView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(19)
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(dayStackView.snp.centerY)
        }
        
        dayStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(34)
            $0.leading.equalToSuperview().inset(43)
        }
        
        answerStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(34)
            $0.trailing.equalToSuperview().inset(43)
        }
        
        topicImageView.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 174 / 375)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 117 / 812)
        }
        
        relationView.snp.makeConstraints {
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 128 / 812)
        }
        
        relationTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }
        
        relationDetailLabel.snp.makeConstraints {
            $0.top.equalTo(relationTitleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(relationTitleLabel.snp.leading)
        }
        
        relationImageView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(16)
        }
        
        albumView.snp.makeConstraints {
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 128 / 812)
        }
        
        albumTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }
        
        albumDetailLabel.snp.makeConstraints {
            $0.top.equalTo(albumTitleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(albumTitleLabel.snp.leading)
        }
        
        albumImageView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(16)
        }
        
        viewStackView.snp.makeConstraints {
            $0.top.equalTo(backgroundView.snp.bottom).offset(16)
            $0.trailing.leading.equalToSuperview().inset(22)
        }
        
        copyrightLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc
    func settingButtonTapped() {
        delegate?.settingButtonTapped()
    }
    
}

extension MyPageView {
    
    func setDataBind(model: MyPageEntity) {
       if model.myUserType == "딸" || model.myUserType == "아들" {
           childMeView.isHidden = false
           parentLabel.text = model.opponentUserType
           parentNicknameLabel.text = model.opponentUsername == nil ? "상대 미연결" : model.opponentUsername
           childLabel.text = model.myUserType
           childNicknameLabel.text = model.myUsername
       } else {
           parentMeView.isHidden = false
           childLabel.snp.remakeConstraints {
               $0.top.equalTo(lineImageView.snp.top)
               $0.leading.equalTo(lineImageView.snp.trailing).offset(10)
           }
           parentLabel.text = model.myUserType
           parentNicknameLabel.text = model.myUsername
           childLabel.text = model.opponentUserType
           childNicknameLabel.text = model.opponentUsername == nil ? "상대 미연결" : model.opponentUsername
       }
        topicLabel.text = "지금은 \(model.section)"
        topicLabel.partFontChange(targetString: model.section, font: .Cafe24Regular(size: 20))
        dayLabel.text = "\(model.matchedDate)일 째"
        answerLabel.text = "\(model.qnaCnt)개"
    }

}
