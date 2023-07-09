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
        label.textColor = .Primary600
        label.clipsToBounds = true
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
        
        self.layer.cornerRadius = 13
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.Primary600.cgColor
        self.backgroundColor = .UmbbaWhite
        
    }
    
    func setHierarchy() {
        addSubview(archivingSectionLabel)
    }
    
    func setLayout() {
        archivingSectionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    func setDataBind(model: ArchivingSectionItem) {
        archivingSectionLabel.text = model.keywordTitle
    }
}
