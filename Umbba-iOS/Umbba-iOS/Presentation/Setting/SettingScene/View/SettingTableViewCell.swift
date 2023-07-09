//
//  SettingTableViewCell.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/07.
//

import UIKit

import SnapKit

class SettingTableViewCell: UITableViewCell {

    static let identifier = "SettingTableViewCell"
    
    // MARK: - UI Components
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .PretendardRegular(size: 16)
        label.textColor = .gray
        return label
    }()
    
    private lazy var buttonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow_forward")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        return imageView
    }()
    
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

extension SettingTableViewCell {
    
    func setUI() {
        contentView.backgroundColor = .white
        separatorInset.left = 0
        selectionStyle = .none
    }
    
    func setLayout() {
        contentView.addSubviews(contentLabel, buttonImage)
        
        contentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(24)
        }
        
        buttonImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-24)
            $0.size.equalTo(18)
        }
    }
    
    func configureCell(_ setting: Setting) {
        contentLabel.text = setting.title
    }
}
