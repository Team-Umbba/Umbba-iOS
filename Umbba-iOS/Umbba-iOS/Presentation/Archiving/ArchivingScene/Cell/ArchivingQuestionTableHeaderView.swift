//
//  ArchivingQuestionTableHeaderView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/09/17.
//

import UIKit

import SnapKit

final class ArchivingQuestionTableHeaderView: UITableViewHeaderFooterView, UITableViewHeaderFooterRegisterable {
    
    // MARK: - Properties
    
    static var isFromNib: Bool = false
    
    // MARK: - UI Components
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = .Cafe24Regular(size: 20)
        label.textColor = .Primary600
        label.text = I18N.Archiving.sectionArray[0]
        return label
    }()
    
    // MARK: - Life Cycles
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
       
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension ArchivingQuestionTableHeaderView {
    
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
}
