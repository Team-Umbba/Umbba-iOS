//
//  AnimationView.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/16.
//

import UIKit
import SnapKit

import AVFoundation

final class AnimationView: UIView {
    
    // MARK: - Properties
    
    weak var nextDelegate: NextButtonDelegate?
    
    // MARK: - UI Components
    
    let backgroundImage: UIImageView = {
        let animationImage = UIImageView()
        animationImage.contentMode = .scaleAspectFill
        return animationImage
    }()
    
    private let animationLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.animationLabel
        label.font = .PretendardSemiBold(size: 16)
        label.textColor = .white
        return label
    }()
    
    private let callingButton: UIButton = {
        let button = CustomButton(status: false, title: I18N.Onboarding.callingButton)
        button.layer.borderColor = UIColor.Primary500.cgColor
        button.layer.borderWidth = 2
        button.setBackgroundColor(.UmbbaWhite, for: .normal)
        button.setTitleColor(.Primary500, for: .normal)
        button.adjustsImageWhenHighlighted = false
        button.isEnabled = true
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setAddTarget()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension AnimationView {
    
    func setAddTarget() {
        callingButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    func setHierarchy() {
        addSubviews(backgroundImage, animationLabel, callingButton)
    }
    func setLayout() {
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        animationLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(33)
        }
        
        callingButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
    @objc
    func nextButtonTapped() {
        nextDelegate?.nextButtonTapped()
    }
    
    func playVideo() {
        guard let path = Bundle.main.path(forResource: "AnimationMp4", ofType: "mp4") else {
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = backgroundImage.bounds
        backgroundImage.layer.addSublayer(playerLayer)
        playerLayer.videoGravity = .resizeAspectFill
        player.play()
        callingButton.isHidden = true
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            playerLayer.removeFromSuperlayer()
            self.playGif()
        }
    }
    
    func playGif() {
        animationLabel.isHidden = true
        callingButton.isHidden = false
        
        guard let gifURL = Bundle.main.url(forResource: "AnimationGif", withExtension: "gif") else { return }
        guard let gifData = try? Data(contentsOf: gifURL) else { return }
        guard let gifImage = UIImage.gifImageWithData(gifData) else { return }
        backgroundImage.image = gifImage
    }
}
