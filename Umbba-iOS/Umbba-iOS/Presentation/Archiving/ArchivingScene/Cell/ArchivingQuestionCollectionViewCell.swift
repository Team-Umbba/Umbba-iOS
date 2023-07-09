//
//  ArchivingQuestionCollectionViewCell.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/09.
//

import UIKit

import SnapKit

final class ArchivingQuestionCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ArchivingQuestionCollectionViewCell"
    
    private let questionNumber: UILabel = {
        let label = UILabel()
        label.font = .Cafe24Regular(size: 16)
        label.textColor = .Primary500
        return label
    }()
    
    private let questionText: UILabel = {
        let label = UILabel()
        label.font = .PretendardRegular(size: 16)
        label.textColor = .UmbbaBlack
        return label
    }()
    
    private let lineView: UIView = {
        let line = UIView()
        line.backgroundColor = .Gray400
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // MARK: - UI Components
        setUI()
        
        // MARK: - addsubView
        setHierarchy()
        
        // MARK: - layout
        setLayout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ArchivingQuestionCollectionViewCell {
    
    func setUI() {
        backgroundColor = .UmbbaWhite
    }
    
    func setHierarchy() {
        addSubviews(questionNumber, questionText, lineView)
    }
    
    func setLayout() {
        questionNumber.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(39)
        }
        
        questionText.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
            $0.leading.equalTo(questionNumber.snp.trailing).offset(16)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(questionText.snp.bottom).offset(19)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    func setDataBind(model: ArchivingQuestionItem) {
        questionNumber.text = "#" + String(model.questions.id)
        questionText.text = model.questions.question
    }
}