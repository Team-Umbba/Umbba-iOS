//
//  CustomButton.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/04.
//

import UIKit

final class CustomButton: UIButton {
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(status: Bool, title: String) {
        self.init()
        setUI(status: status, title: title)
    }
}

// MARK: - Extensions

private extension CustomButton {
    func setUI(status: Bool, title: String) {
        self.isEnabled = status
        self.setBackgroundColor(.gray, for: .disabled)
        self.setBackgroundColor(.black, for: .normal)
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .PretendardBold(size: 16)
        self.layer.cornerRadius = 30
    }
}
