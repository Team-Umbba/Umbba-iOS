//
//  SettingTableViewCell.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/07.
//

import UIKit

import SnapKit

final class SettingTableViewCell: UITableViewCell, UITableViewRegisterable {
    
    // MARK: - Properties
    
    static var isFromNib = false
    
    // MARK: - UI Components
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .PretendardRegular(size: 16)
        label.textColor = .gray
        return label
    }()
    
    lazy var buttonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.compact.right")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        return imageView
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
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Extensions

private extension SettingTableViewCell {
    
    func setUI() {
        self.backgroundColor = .White500
        separatorInset.left = 0
        self.selectionStyle = .none
    }
    
    func setLayout() {
        contentView.addSubviews(contentLabel, buttonImage, lineView)
        
        contentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
        }
        
        buttonImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(24)
            $0.size.equalTo(18)
        }
        
        lineView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
