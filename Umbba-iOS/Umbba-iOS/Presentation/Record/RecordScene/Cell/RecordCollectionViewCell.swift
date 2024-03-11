//
//  RecordCollectionViewCell.swift
//  Umbba-iOS
//
//  Created by 고아라 on 1/27/24.
//

import UIKit

import SnapKit
import Kingfisher

final class RecordCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties

    static let isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .Primary600.withAlphaComponent(0.5)
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 17
        view.clipsToBounds = false
        return view
    }()
    
    private let recordTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "설이 귀여움"
        label.textColor = .White500
        label.textAlignment = .center
        label.font = .PretendardSemiBold(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var recordDeleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .iconTrash), for: .normal)
        return button
    }()
    
    private let recordImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(resource: .seHome2)
        image.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        image.layer.cornerRadius = 17
        return image
    }()
    
    private let recordContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .Primary600.withAlphaComponent(0.5)
        view.layer.cornerRadius = 17
        view.clipsToBounds = false
        return view
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "머리가 참외같이\n작아서 놀랐던 날"
        label.textColor = .White400
        label.font = .PretendardSemiBold(size: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let writerLabel: UILabel = {
        let label = UILabel()
        label.text = "작성자"
        label.textColor = .Primary400
        label.font = .PretendardRegular(size: 16)
        return label
    }()
    
    private let openQuoteImage = UIImageView(image: UIImage(resource: .iconOpenQuote))
    private let closeQuoteImage = UIImageView(image: UIImage(resource: .iconCloseQuote))
    
    private let touchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let touchImage = UIImageView(image: UIImage(resource: .recordTouch))
    
    private let touchTitle: UILabel = {
        let label = UILabel()
        label.text = "터치하기"
        label.textColor = .White400
        label.textAlignment = .center
        label.font = .PretendardRegular(size: 12)
        return label
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setUI()
        setHierarchy()
        setLayout()
        setGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleView.isHidden = false
        recordContentView.isHidden = true
    }
}

// MARK: - Extensions

private extension RecordCollectionViewCell {

    func setUI() {
        backgroundColor = .clear
        self.clipsToBounds = true
        self.layer.cornerRadius = 17
        titleView.isHidden = false
        recordContentView.isHidden = true
        touchStackView.isHidden = true
    }
    
    func setHierarchy() {
        titleView.addSubview(recordTitleLabel)
        recordContentView.addSubviews(openQuoteImage, contentLabel, closeQuoteImage, writerLabel)
        touchStackView.addArrangedSubviews(touchImage, touchTitle)
        self.addSubviews(recordImage, touchStackView, titleView, recordContentView, recordDeleteButton)
    }
    
    func setLayout() {
        recordImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(51)
        }
        
        recordTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.centerY.equalToSuperview()
        }
        
        recordDeleteButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.size.equalTo(48)
        }
        
        recordContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        openQuoteImage.snp.makeConstraints {
            $0.top.equalTo(recordDeleteButton.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 32 / 812)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(16)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(openQuoteImage.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 24 / 812)
            $0.centerX.equalToSuperview()
        }
        
        closeQuoteImage.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 24 / 812)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(16)
        }
        
        writerLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 70 / 812)
            $0.centerX.equalToSuperview()
        }
        
        touchStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func handleTap(_ sender: UITapGestureRecognizer) {
        if recordContentView.isHidden {
            titleView.isHidden = true
            touchStackView.isHidden = true
            recordContentView.isHidden = false
        } else {
            titleView.isHidden = false
            touchStackView.isHidden = false
            recordContentView.isHidden = true
        }
    }
}

extension RecordCollectionViewCell {
    
    func configureCell(model: AlbumEntity) {
        touchStackView.isHidden = model.albumID == 0 ? false : true
        recordTitleLabel.text = model.title
        contentLabel.text = model.content
        writerLabel.text = model.writer
        recordImage.kf.setImage(with: URL(string: model.imgURL ?? ""))
    }
}
