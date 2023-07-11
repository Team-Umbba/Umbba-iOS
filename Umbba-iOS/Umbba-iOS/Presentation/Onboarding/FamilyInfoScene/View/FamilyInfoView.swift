//
//  FamilyInfoView.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/09.
//

import UIKit

import SnapKit

final class FamilyInfoView: UIView {
    
    // MARK: - Properties
    
    weak var navigationdelegate: NavigationBarDelegate?
    weak var nextDelegate: NextButtonDelegate?
    
    private var selectedRelationButton: Int = 0
    private var relationButton: [UIButton] = []
    private var selectedGenderButton: Int = 0
    private var genderButton: [UIButton] = []
    
    // MARK: - UI Components
    
    private let navigationBarView: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.isLeftButtonIncluded = true
        return view
    }()
    
    private let familyInfoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.familyInfoTitle
        label.font = .PretendardRegular(size: 24)
        label.setLineSpacingPartFontChange(lineSpacing: 5.0, targetString: "과거", font: .PretendardBold(size: 24))
        label.numberOfLines = 0
        return label
    }()
    
    private let relationView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.Gray400.cgColor
        view.layer.masksToBounds = true
        return view
    }()
    
    private let relationLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.relationInfo
        label.textColor = .UmbbaBlack
        label.font = .PretendardSemiBold(size: 20)
        return label
    }()
    
    private lazy var parentButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.Gray300, for: .normal)
        button.setBackgroundColor(.Gray800, for: .selected)
        button.setTitle(I18N.Onboarding.parent, for: .normal)
        button.setTitleColor(.UmbbaBlack, for: .normal)
        button.setTitleColor(.UmbbaWhite, for: .selected)
        button.titleLabel?.font = .PretendardRegular(size: 16)
        button.layer.cornerRadius = 24
        button.adjustsImageWhenHighlighted = false
        relationButton.append(button)
        return button
    }()
    
    private lazy var childButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.Gray300, for: .normal)
        button.setBackgroundColor(.Gray800, for: .selected)
        button.setTitle(I18N.Onboarding.child, for: .normal)
        button.setTitleColor(.UmbbaBlack, for: .normal)
        button.setTitleColor(.UmbbaWhite, for: .selected)
        button.titleLabel?.font = .PretendardRegular(size: 16)
        button.layer.cornerRadius = 24
        button.adjustsImageWhenHighlighted = false
        relationButton.append(button)
        return button
    }()
    
    private lazy var relationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 13
        stackView.addArrangedSubviews(parentButton, childButton)
        return stackView
    }()
    
    private let genderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.Gray400.cgColor
        view.layer.masksToBounds = true
        view.alpha = 0.0
        return view
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.detailnfo
        label.textColor = .black
        label.font = .PretendardSemiBold(size: 20)
        return label
    }()
    
    private lazy var maleButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.Gray300, for: .normal)
        button.setBackgroundColor(.Gray800, for: .selected)
        button.setTitleColor(.UmbbaBlack, for: .normal)
        button.setTitleColor(.UmbbaWhite, for: .selected)
        button.titleLabel?.font = .PretendardRegular(size: 16)
        button.layer.cornerRadius = 24
        button.adjustsImageWhenHighlighted = false
        genderButton.append(button)
        return button
    }()
    
    private lazy var femaleButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.Gray300, for: .normal)
        button.setBackgroundColor(.Gray800, for: .selected)
        button.setTitleColor(.UmbbaBlack, for: .normal)
        button.setTitleColor(.UmbbaWhite, for: .selected)
        button.titleLabel?.font = .PretendardRegular(size: 16)
        button.layer.cornerRadius = 24
        button.adjustsImageWhenHighlighted = false
        genderButton.append(button)
        return button
    }()
    
    private lazy var genderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 13
        stackView.addArrangedSubviews(maleButton, femaleButton)
        return stackView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 12
        stackView.addArrangedSubviews(relationView, genderView)
        return stackView
    }()
    
    private lazy var nextButton: CustomButton = {
        let button = CustomButton(status: false, title: I18N.Common.nextButtonTitle)
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setAddTarget()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension FamilyInfoView {
    func setUI() {
        self.backgroundColor = .UmbbaWhite
    }
    
    func setAddTarget() {
        navigationBarView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        parentButton.addTarget(self, action: #selector(relationButtonTapped), for: .touchUpInside)
        childButton.addTarget(self, action: #selector(relationButtonTapped), for: .touchUpInside)
        maleButton.addTarget(self, action: #selector(genderButtonTapped), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(genderButtonTapped), for: .touchUpInside)
    }
    
    func setLayout() {
        self.addSubviews(navigationBarView, familyInfoTitleLabel, infoStackView, nextButton)
        relationView.addSubviews(relationLabel, relationStackView)
        genderView.addSubviews(genderLabel, genderStackView)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        familyInfoTitleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(24)
        }
        
        infoStackView.snp.makeConstraints {
            $0.top.equalTo(familyInfoTitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        relationView.snp.makeConstraints {
            $0.height.equalTo(136)
        }
        
        relationLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(24)
        }
        
        parentButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        childButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        relationStackView.snp.makeConstraints {
            $0.top.equalTo(relationLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
        
        genderView.snp.makeConstraints {
            $0.height.equalTo(136)
        }
        
        genderLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(24)
        }
        
        maleButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        femaleButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        genderStackView.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
    // MARK: - Functions
    
    func setGenderButtonTitle(male: String, female: String) {
        maleButton.setTitle(male, for: .normal)
        femaleButton.setTitle(female, for: .normal)
    }
    
    func isFilledAnswer() {
        if (maleButton.isSelected || femaleButton.isSelected)
            && (maleButton.isSelected || femaleButton.isSelected) {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }
    
    func updateGenderButtonUI() {
        maleButton.isSelected = false
        femaleButton.isSelected = false
    }
    
    // MARK: - @objc Functions
    
    @objc
    func backButtonTapped() {
        navigationdelegate?.backButtonTapped()
    }
    
    @objc
    func nextButtonTapped() {
        nextDelegate?.nextButtonTapped()
    }
    
    @objc
    func relationButtonTapped(sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.genderView.alpha = 1.0
        }
        self.selectedRelationButton = sender.tag
        relationButton.forEach { button in
            guard let relation = button.titleLabel?.text else { return }
            button.isSelected = sender == button
            if button.isSelected {
                print(relation)
                let maleTitle = relation == "부모님" ? I18N.Onboarding.dad : I18N.Onboarding.son
                let femaleTitle = relation == "부모님" ? I18N.Onboarding.mom : I18N.Onboarding.daughter
                setGenderButtonTitle(male: maleTitle, female: femaleTitle)
                updateGenderButtonUI()
            }
        }
        isFilledAnswer()
    }
    
    @objc
    func genderButtonTapped(sender: UIButton) {
        self.selectedGenderButton = sender.tag
        genderButton.forEach { button in
            guard let gender = button.titleLabel?.text else { return }
            button.isSelected = sender == button
            if button.isSelected {
                print(gender)
            }
        }
        isFilledAnswer()
    }
}
