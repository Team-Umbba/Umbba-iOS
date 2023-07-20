//
//  QuestCollectionCell.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/15.
//

import UIKit

import SnapKit

protocol QuestDelegte: AnyObject {
    func selectAnswer(_ cell: QuestCollectionViewCell, questionIndex: Int, answerIndex: Int)
}

final class QuestCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    static let isFromNib: Bool = false
    
    // MARK: - Properties
    
    weak var questDelegate: QuestDelegte?
    private var selectedButton: Int = 0
    private var answerButton: [UIButton] = []
    private var answerArray: [String] = []
    
    var questionIndex: Int?
    var answerIndex: Int? {
        didSet {
            guard let index = answerIndex else { return }
            updateButtonState(index)
        }
    }
    
    // MARK: - UI Components
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.font = .PretendardSemiBold(size: 20)
        label.textColor = .UmbbaBlack
        label.numberOfLines = 0
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
        button.tag = 0
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
        button.tag = 1
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
        button.tag = 2
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
    
    var isAnswered: Bool {
        return yesButton.isSelected || noButton.isSelected || skipButton.isSelected
    }
    
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
    
    @objc func questButtonTapped(sender: UIButton) {
        answerIndex = sender.tag
        if let questionIndex = questionIndex,
           let answerIndex = answerIndex {
            questDelegate?.selectAnswer(self, questionIndex: questionIndex, answerIndex: answerIndex)
        }
    }
    
    func updateButtonState(_ selectedButtonIndex: Int) {
        [yesButton, noButton, skipButton]
            .forEach { button in
                let isSelected = button.tag == selectedButtonIndex
                button.isSelected = isSelected
            }
    }
}
