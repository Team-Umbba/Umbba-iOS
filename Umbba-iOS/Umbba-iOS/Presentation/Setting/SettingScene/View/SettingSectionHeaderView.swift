//
//  SettingSectionHeaderView.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/09.
//

import UIKit

import SnapKit

class SettingSectionHeaderView: UIView {

    // MARK: - UI Components
    
    private let settingLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Setting.settingLabel
        label.font = .PretendardRegular(size: 16)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingSectionHeaderView {
    
    func setUI() {
        backgroundColor = .white
    }
    
    func setLayout() {
        addSubview(settingLabel)
        
        settingLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(24)
        }
    }
}
