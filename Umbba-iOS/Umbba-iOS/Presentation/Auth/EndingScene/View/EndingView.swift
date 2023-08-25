//
//  EndingView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/08/25.
//

import UIKit

import SnapKit

final class EndingView: UIView {
    
    // MARK: - UI Components
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.GradientHigh.withAlphaComponent(0.38).cgColor, UIColor.GradientHigh.withAlphaComponent(0).cgColor]
        gradient.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 217 / 812 * SizeLiterals.Screen.screenHeight)
        return gradient
    }()
    
    private let endingImageView: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.Ending.ending_img
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        setGradient()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Extensions

extension EndingView {
    func setUI() {
        backgroundColor = .UmbbaWhite
    }
    
    func setGradient() {
        layer.addSublayer(gradientLayer)
    }
    
    func setHierarchy() {
        addSubview(endingImageView)
    }
    
    func setLayout() {
        endingImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(271)
        }
    }
}
