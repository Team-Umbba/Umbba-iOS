//
//  MainView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/14.
//

import UIKit

import SnapKit

protocol MainDelegate: AnyObject {
    func questionButtonTapped()
}

final class MainView: UIView {
    
    // MARK: - UI Components
    
    weak var delegate: AlertDelegate?
    weak var mainDelegate: MainDelegate?
    
    private let questionImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let questionView: UIView = {
        let view = UIView()
        view.backgroundColor = .Primary600
        view.clipsToBounds = true
        view.layer.cornerRadius = (SizeLiterals.Screen.screenHeight * 56 / 812) / 2
        return view
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
    
    private lazy var questionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.backgroundColor = .Primary600
        stackView.layer.cornerRadius = 30
        stackView.addArrangedSubviews(questionNumLabel, questionTitleLabel)
        return stackView
    }()
    
    private lazy var questionButton: CustomButton = {
        let button = CustomButton(status: true, title: I18N.Home.questionButtonTitle)
        button.setBackgroundColor(.UmbbaWhite, for: .normal)
        button.setTitleColor(.Primary500, for: .normal)
        button.layer.borderColor = UIColor.Primary500.cgColor
        button.layer.borderWidth = 2
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

extension MainView {
    func setUI() {
        backgroundColor = .UmbbaWhite
    }
    
    func setHierarchy() {
        questionView.addSubview(questionStackView)
        addSubviews(questionImage, questionView, questionButton)
    }
    
    func setLayout() {
        questionImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaInsets)
        }
        
        questionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(63)
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 56 / 812)
        }
        
        questionStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.centerY.equalToSuperview()
        }
        
        questionButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(13)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
    func setAddTarget() {
        questionButton.addTarget(self, action: #selector(questionButtonTapped), for: .touchUpInside)
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
    
    @objc
    func questionButtonTapped() {
        mainDelegate?.questionButtonTapped()
    }
}
