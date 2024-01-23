//
//  LoadingView.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/08/26.
//

import UIKit

import Lottie
import SnapKit
import Kingfisher

final class LoadingView: UIView {
    
    // MARK: - Properties
    
    static let shared = LoadingView()
    
    // MARK: - UI Components
    
    let loadingSplashView: UIImageView = {
        let imageView = UIImageView()
        let gifs = ["https://github.com/Team-Umbba/Umbba-iOS/assets/75068759/b40de055-5d7a-403a-ad83-17b6a1012dd5"]
        imageView.kf.setImage(with: URL(string: gifs[0])!)
        return imageView
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
        self.backgroundColor = .White500.withAlphaComponent(0.5)
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
    }

    func hide(completion: @escaping () -> Void) {
        self.removeFromSuperview()
        completion()
    }
}
