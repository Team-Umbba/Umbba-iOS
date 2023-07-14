//
//  MainView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/14.
//

import UIKit

import SnapKit

final class MainView: UIView {
    
    // MARK: - UI Components
    
    private let questionImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .Primary600
        label.clipsToBounds = true
        label.layer.cornerRadius = 30
        return label
    }()
    
    private let questionNumLabel: UILabel = {
        let label = UILabel()
        label.font = .Cafe24Regular(size: 16)
        label.textColor = .white
        return label
    }()
    
    private let questionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Cafe24Regular(size: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var questionButton: CustomButton = {
        let button = CustomButton(status: true, title: I18N.Main.questionButtonTitle)
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setUI()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Extensions

extension MainView {
    func setUI() {
        backgroundColor = .UmbbaWhite
    }
    
    func setHierarchy() {
        questionLabel.addSubviews(questionNumLabel, questionTitleLabel)
        addSubviews(questionImage, questionLabel, questionButton)
    }
    
    func setLayout() {
        questionImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(63)
            $0.leading.equalToSuperview().inset(24)
            $0.width.equalTo(261)
            $0.height.equalTo(56)
        }
        
        questionNumLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(40)
        }
        
        questionTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(40)
        }
        
        questionButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(13)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }

    func setDataBind(model: MainItem) {
        switch model.section {
        case "어린시절":
            questionImage.image = ImageLiterals.Home.main_1
        case "학창시절":
            questionImage.image = ImageLiterals.Home.main_2
        case "청춘시절":
            questionImage.image = ImageLiterals.Home.main_3
        case "연애시절":
            questionImage.image = ImageLiterals.Home.main_4
        case "우리가만나고":
            questionImage.image = ImageLiterals.Home.main_5
        default:
            questionImage.image = ImageLiterals.Home.main_1
        }
        questionNumLabel.text = "#\(model.count)"
        questionTitleLabel.text = model.topic
    }
}
