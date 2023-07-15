//
//  ArchivingImageView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/09.
//

import UIKit

import SnapKit

final class ArchivingImageView: UIView {
    
    // MARK: - Properties
    
    private let imageArray = [ImageLiterals.Archiving.list_img1, ImageLiterals.Archiving.list_img2, ImageLiterals.Archiving.list_img3, ImageLiterals.Archiving.list_img4, ImageLiterals.Archiving.list_img5]
    
    private let imageSeArray = [ImageLiterals.Archiving.list_se_img1, ImageLiterals.Archiving.list_se_img2, ImageLiterals.Archiving.list_se_img3, ImageLiterals.Archiving.list_se_img4, ImageLiterals.Archiving.list_se_img5]

    // MARK: - UI Components
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        image.layer.cornerRadius = 20
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
        }
    }
    
    func setDataBind(section: Int) {
        imageView.image = imageArray[section]
    }
    
    func setSEDataBind(section: Int) {
        imageView.image = imageSeArray[section]
    }
}
