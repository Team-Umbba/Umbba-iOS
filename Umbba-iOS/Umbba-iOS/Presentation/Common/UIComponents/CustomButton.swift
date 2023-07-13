//
//  CustomButton.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/04.
//

import UIKit

final class CustomButton: UIButton {
    
    // MARK: - UI Components
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.GradientLow.cgColor, UIColor.GradientMedium.cgColor, UIColor.GradientHigh.cgColor]
//        gradient.transform = CATransform3DMakeRotation(CGFloat.pi, 0, 0, 1) // 그라데이션 표시 설정 (가로 = 3색 기준)
        gradient.locations = [0.0, 0.5, 1.0] // 각각 색상이 표시될 공간 [3색 기준]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        layer.insertSublayer(gradient, at: 0)
        return gradient
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
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
        self.setBackgroundColor(.Gray400, for: .disabled)
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .PretendardBold(size: 16)
        self.layer.cornerRadius = 30
    }
}
