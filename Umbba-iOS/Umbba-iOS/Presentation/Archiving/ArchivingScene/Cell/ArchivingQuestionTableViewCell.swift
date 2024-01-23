//
//  ArchivingQuestionTableViewCell.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/09/17.
//

import UIKit

import SnapKit

final class ArchivingQuestionTableViewCell: UITableViewCell, UITableViewRegisterable {
    
    // MARK: - Properties
    
    static let isFromNib: Bool = false
    
    // MARK: - UI Components
    
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

    // MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension ArchivingQuestionTableViewCell {
    func setUI() {
        backgroundColor = .White500
        self.isUserInteractionEnabled = true
        self.selectionStyle = .none
    }
    
    func setHierarchy() {
        contentView.addSubviews(questionNumber, questionText, lineView)
    }
    
    func setLayout() {
        questionNumber.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(24)
        }
        
        questionText.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(questionNumber.snp.trailing).offset(16)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(questionText.snp.bottom).offset(19)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    func setDataBind(model: ListEntity) {
        questionNumber.text = "#\(model.index)"
        questionText.text = model.topic
    }
}
