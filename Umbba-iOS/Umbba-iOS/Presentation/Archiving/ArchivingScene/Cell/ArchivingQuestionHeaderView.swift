//
//  ArchivingQuestionHeaderView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/09.
//

import UIKit

import SnapKit

final class ArchivingQuestionHeaderView: UICollectionReusableView {
    
    static let identifier = "ArchivingQuestionHeaderView"

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .Cafe24Regular(size: 20)
        label.text = "어린 시절"
        label.textColor = .Primary600
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // MARK: - addsubView
        setHierarchy()
        
        // MARK: - autolayout설정
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension ArchivingQuestionHeaderView {
    
    func setHierarchy() {
        addSubview(headerLabel)
    }
    
    func setLayout() {
        headerLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(21)
        }
    }
}
