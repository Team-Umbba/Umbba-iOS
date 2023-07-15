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

extension ArchivingImageView {
    
    func setUI() {
        imageView.contentMode = .scaleAspectFill
    }
    
    func setHierarchy() {
        addSubview(imageView)
    }
    
    func setLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 375 / 812)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 375 / 812)
        }
    }
    
    func setDataBind(section: Int) {
        switch section {
        case 0:
            imageView.image = ImageLiterals.Archiving.list_img1
        case 1:
            imageView.image = ImageLiterals.Archiving.list_img2
        case 2:
            imageView.image = ImageLiterals.Archiving.list_img3
        case 3:
            imageView.image = ImageLiterals.Archiving.list_img4
        case 4:
            imageView.image = ImageLiterals.Archiving.list_img5
        default:
            imageView.image = ImageLiterals.Archiving.list_img1
        }
    }
}
