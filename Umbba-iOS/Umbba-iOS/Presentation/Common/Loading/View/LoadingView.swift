//
//  LoadingView.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/08/26.
//

import UIKit

import Lottie
import SnapKit

class LoadingView: UIView {
    
    // MARK: - Properties
    
    static let shared = LoadingView()
    
    // MARK: - UI Components
    
    let loadingSplashView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "splash_iOS")
        animationView.loopMode = .loop
        return animationView
    }()

    // MARK: - Life Cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension LoadingView {
    func setUI() {
        backgroundColor = .UmbbaBlack.withAlphaComponent(0.7)
        
        loadingSplashView.frame = bounds
        loadingSplashView.center = center
        loadingSplashView.contentMode = .scaleAspectFit
        loadingSplashView.backgroundColor = .clear
    }
    
    func setLayout() {
        addSubview(loadingSplashView)
        
        loadingSplashView.snp.makeConstraints {
            $0.size.equalTo(88)
            $0.center.equalToSuperview()
        }
    }
    
    func show(_ view: UIView) {
        view.addSubview(self)
        
        self.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.layoutIfNeeded()
        self.loadingSplashView.play()
            UIView.animate(
              withDuration: 0.7,
              animations: { self.alpha = 1 }
            )
    }

    func hide(completion: @escaping () -> ()) {
        self.loadingSplashView.stop()
        self.removeFromSuperview()
        completion()
    }
}
