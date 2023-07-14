//
//  ArchivingQuestionHeaderView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/09.
//

import UIKit

import SnapKit

final class ArchivingQuestionHeaderView: UICollectionReusableView, UICollectionHeaderViewRegisterable {
    
    static let isFromNib: Bool = false

    // MARK: - UI Components
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .Cafe24Regular(size: 20)
        label.textColor = .Primary600
        return label
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

extension ArchivingQuestionHeaderView {
    
    func setUI() {
        self.backgroundColor = .UmbbaWhite
    }
    
    func setHierarchy() {
        addSubview(headerLabel)
    }
    
    func setLayout() {
        headerLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(21)
        }
    }
    
    func setDataBind(model: ArchivingQuestionItem) {
        headerLabel.text = I18N.Archiving.sectionArray[model.index]
    }
}
