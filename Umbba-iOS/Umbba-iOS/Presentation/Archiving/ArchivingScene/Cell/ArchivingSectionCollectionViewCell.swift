//
//  ArchivingSectionCollectionViewCell.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/09.
//

import UIKit

import SnapKit

protocol ArchivingDelegate: AnyObject {
    func labelTapped(index: Int)
}

final class ArchivingSectionCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    static let isFromNib: Bool = false
    
    var selectedSectionIndexPath: Int = 0
    
    weak var delegate: ArchivingDelegate?
    
    // MARK: - Properties
    
    let archivingSectionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .PretendardRegular(size: 12)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension ArchivingSectionCollectionViewCell {
    
    func setUI() {
        self.layer.cornerRadius = 13
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.Primary600.cgColor
        self.backgroundColor = .UmbbaWhite
        self.isUserInteractionEnabled = true
    }
    
    func setHierarchy() {
        contentView.addSubview(archivingSectionLabel)
    }
    
    func setLayout() {
        archivingSectionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    @objc func labelTapped(index: Int) {
        delegate?.labelTapped(index: index)
    }
}
