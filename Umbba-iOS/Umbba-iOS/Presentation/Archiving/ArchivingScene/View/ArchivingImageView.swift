//
//  ArchivingImageView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/09.
//

import UIKit

import SnapKit

final class ArchivingImageView: UIView {

    // MARK: - UI Components
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        image.layer.cornerRadius = 20
        return image
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Extensions

private extension ArchivingImageView {
    
    func setHierarchy() {
        addSubview(imageView)
    }
    
    func setLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 360 / 812)
        }
    }
}
