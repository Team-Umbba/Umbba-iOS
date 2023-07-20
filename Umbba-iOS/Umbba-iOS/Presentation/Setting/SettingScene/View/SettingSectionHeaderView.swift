//
//  SettingSectionHeaderView.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/09.
//

import UIKit

import SnapKit

final class SettingSectionHeaderView: UITableViewHeaderFooterView, UITableViewHeaderFooterRegisterable {
   
    // MARK: - Properties
    
    static var isFromNib = false
    
    // MARK: - UI Components
    
    private let settingLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Setting.settingLabel
        label.font = .PretendardRegular(size: 16)
        label.textColor = .gray
        return label
    }()
    
    private lazy var alarmSwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.onTintColor = .Primary500
        mySwitch.isOn = UserManager.shared.getAllowAlarm
        return mySwitch
    }()
    
    private let lineView: UIView = {
        let line = UIView()
        line.backgroundColor = .Gray400
        return line
    }()
    
    // MARK: - Life Cycles
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
       
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension SettingSectionHeaderView {
    
    func setUI() {
        contentView.backgroundColor = .UmbbaWhite
    }
    
    func setLayout() {
        contentView.addSubviews(settingLabel, alarmSwitch, lineView)
        
        settingLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(24)
        }
        
        alarmSwitch.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(24)
        }
        
        lineView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
