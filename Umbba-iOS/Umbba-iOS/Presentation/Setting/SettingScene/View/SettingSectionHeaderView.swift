//
//  SettingSectionHeaderView.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/09.
//

import UIKit

import SnapKit

class SettingSectionHeaderView: UITableViewHeaderFooterView, UITableViewHeaderFooterRegisterable {
   
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
        return mySwitch
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
       
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
        addSubviews(settingLabel, alarmSwitch)
        
        settingLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(24)
        }
        
        alarmSwitch.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-24)
        }
    }
}
