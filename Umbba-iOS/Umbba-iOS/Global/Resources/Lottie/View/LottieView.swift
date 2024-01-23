//
//  LottieView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/13.
//

import UIKit

import SnapKit
import Lottie

final class LottieView: UIView {
    
    // MARK: - UI Components

    let lottieSplashView: LottieAnimationView = LottieAnimationView(name: "splash_iOS")
    private let lottieTitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Auth.logoTitle
        label.font = .Cafe24Regular(size: 16)
        label.textColor = .Primary500
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.spacing = 8
        stackview.alignment = .center
        stackview.axis = .vertical
        stackview.addArrangedSubviews(lottieSplashView, lottieTitleLabel)
        return stackview
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setUI()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension LottieView {
    func setUI() {
        backgroundColor = .White500
        
        lottieSplashView.frame = bounds
        lottieSplashView.center = center
        lottieSplashView.contentMode = .scaleAspectFit
        lottieSplashView.backgroundColor = .clear
    }
    
    func setHierarchy() {
        addSubview(stackView)
    }
    
    func setLayout() {
        lottieSplashView.snp.makeConstraints {
            $0.size.equalTo(88)
        }
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
