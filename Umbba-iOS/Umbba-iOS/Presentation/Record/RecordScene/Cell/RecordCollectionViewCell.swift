//
//  RecordCollectionViewCell.swift
//  Umbba-iOS
//
//  Created by 고아라 on 1/27/24.
//

import UIKit

import SnapKit

final class RecordCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties

    static let isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let recordTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "글자수글자수"
        label.textColor = .Gray800
        label.textAlignment = .center
        label.font = .PretendardRegular(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "승준"
        label.textColor = .Gray800
        label.font = .PretendardRegular(size: 12)
        label.numberOfLines = 0
        return label
    }()
    
    private let divideView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray300
        return view
    }()
    
    private let recordSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "머리가 참외같이\n작아서 놀랐던 날"
        label.textColor = .Gray900
        label.font = .PretendardRegular(size: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let recordImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(resource: .home1)
        image.clipsToBounds = true
        return image
    }()
    
    private let openQuoteImage = UIImageView(image: UIImage(resource: .icOpenQuote))
    private let closeQuoteImage = UIImageView(image: UIImage(resource: .icCloseQuote))
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .icExit), for: .normal)
        button.tintColor = .Gray800
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension RecordCollectionViewCell {

    func setUI() {
        backgroundColor = .White400
        self.clipsToBounds = true
        self.layer.cornerRadius = 17
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.Gray400.cgColor
    }
    
    func setHierarchy() {
        self.addSubviews(recordTitleLabel, divideView, nameLabel, openQuoteImage, closeQuoteImage, recordSubTitleLabel, deleteButton, recordImage)
    }
    
    func setLayout() {
        recordTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(12)
            $0.width.equalTo(79)
        }
        
        divideView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalTo(recordTitleLabel.snp.trailing).offset(12)
            $0.width.equalTo(1)
        }
        
        nameLabel.snp.makeConstraints {
            $0.trailing.equalTo(divideView.snp.leading).offset(-12)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        openQuoteImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalTo(divideView.snp.trailing).offset(16)
            $0.size.equalTo(16)
        }
        
        closeQuoteImage.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(16)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(5)
            $0.size.equalTo(21)
        }
        
        recordSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(openQuoteImage.snp.bottom)
            $0.leading.equalTo(openQuoteImage.snp.trailing)
            $0.trailing.equalTo(closeQuoteImage.snp.leading)
            $0.bottom.equalTo(closeQuoteImage.snp.top)
            $0.centerY.equalToSuperview()
        }
        
        recordImage.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalTo(divideView.snp.trailing)
        }
    }
}
