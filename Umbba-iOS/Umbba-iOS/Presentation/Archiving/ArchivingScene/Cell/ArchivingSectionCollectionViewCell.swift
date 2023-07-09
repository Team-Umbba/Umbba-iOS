//
//  ArchivingSectionCollectionViewCell.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/09.
//

import UIKit

import SnapKit

final class ArchivingSectionCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ArchivingSectionCollectionViewCell"
    
    private let archivingSectionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .PretendardRegular(size: 12)
        label.textColor = .gray
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.gray.cgColor
        label.backgroundColor = .UmbbaWhite
        label.clipsToBounds = true
        label.layer.cornerRadius = 12
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        
        // MARK: - addsubView
        setHierarchy()
        
        setLayout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ArchivingSectionCollectionViewCell {
    
    func setUI() {
        backgroundColor = .UmbbaWhite
    }
    
    func setHierarchy() {
        addSubview(archivingSectionLabel)
    }
    
    func setLayout() {
        archivingSectionLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(26)
        }
    }
    
    func setDataBind(model: ArchivingSectionItem) {
        archivingSectionLabel.text = model.keywordTitle
    }
}
