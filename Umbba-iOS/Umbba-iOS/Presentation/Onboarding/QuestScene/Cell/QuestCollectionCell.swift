//
//  QuestCollectionCell.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/15.
//

import UIKit

import SnapKit

protocol QuestDelegte: AnyObject {
    func updateNextButton(isEnabled: Bool, answer: String)
}

final class QuestCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    static let isFromNib: Bool = false
    
    // MARK: - Properties
    
    weak var questDelegate: QuestDelegte?
    private var selectedButton: Int = 0
    private var answerButton: [UIButton] = []
    private var answerArray: [String] = []
    
    // MARK: - UI Components
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.font = .PretendardSemiBold(size: 20)
        label.textColor = .UmbbaBlack
        label.numberOfLines = 2
        return label
    }()
    
    lazy var yesButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.UmbbaWhite, for: .normal)
        button.setBackgroundColor(.Primary500, for: .selected)
        button.setTitle("응", for: .normal)
        button.setTitleColor(.UmbbaBlack, for: .normal)
        button.setTitleColor(.UmbbaWhite, for: .selected)
        button.titleLabel?.font = .PretendardRegular(size: 16)
        button.layer.borderColor = UIColor.Gray400.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 24
        button.adjustsImageWhenHighlighted = false
        answerButton.append(button)
        return button
    }()
    
    lazy var noButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.UmbbaWhite, for: .normal)
        button.setBackgroundColor(.Primary500, for: .selected)
        button.setTitle("아니", for: .normal)
        button.setTitleColor(.UmbbaBlack, for: .normal)
        button.setTitleColor(.UmbbaWhite, for: .selected)
        button.titleLabel?.font = .PretendardRegular(size: 16)
        button.layer.borderColor = UIColor.Gray400.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 24
        button.adjustsImageWhenHighlighted = false
        answerButton.append(button)
        return button
    }()
    
    lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.UmbbaWhite, for: .normal)
        button.setBackgroundColor(.Primary500, for: .selected)
        button.setTitle("애매해", for: .normal)
        button.setTitleColor(.UmbbaBlack, for: .normal)
        button.setTitleColor(.UmbbaWhite, for: .selected)
        button.titleLabel?.font = .PretendardRegular(size: 16)
        button.layer.borderColor = UIColor.Gray400.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 24
        button.adjustsImageWhenHighlighted = false
        answerButton.append(button)
        return button
    }()
    
    private lazy var questButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        stackView.addArrangedSubviews(yesButton, noButton, skipButton)
        return stackView
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

extension QuestCollectionViewCell {
    
    func setUI() {
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.Gray400.cgColor
        self.backgroundColor = .white
        self.isUserInteractionEnabled = true
    }
    
    func setLayout() {
        contentView.addSubviews(questionLabel, questButtonStackView)
        
        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(38)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        yesButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        noButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        skipButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        questButtonStackView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(56)
        }
    }
    
    func setAddTarget() {
        yesButton.addTarget(self, action: #selector(questButtonTapped), for: .touchUpInside)
        noButton.addTarget(self, action: #selector(questButtonTapped), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(questButtonTapped), for: .touchUpInside)
    }
    
    func updateNextButton() {
        if yesButton.isSelected || noButton.isSelected || skipButton.isSelected {
            questDelegate?.updateNextButton(isEnabled: true, answer: answerArray.last ?? "")
        } else {
            questDelegate?.updateNextButton(isEnabled: false, answer: answerArray.last ?? "")
        }
    }

    @objc
    func questButtonTapped(sender: UIButton) {
        self.selectedButton = sender.tag
        answerButton.forEach { button in
            guard let gender = button.titleLabel?.text else { return }
            button.isSelected = sender == button
            if button.isSelected {
                print(gender)
                answerArray.append(gender)
            }
        }
        updateNextButton()
    }
}
