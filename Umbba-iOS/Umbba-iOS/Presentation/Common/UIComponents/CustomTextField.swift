//
//  CustomTextField.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/04.
//

import UIKit

final class CustomTextField: UITextField {
    
    // MARK: - Properties
    
    @frozen
    enum CustomTextField {
        case normal
        case editing
        case uncorrectedType
        
        var borderColor: CGColor? {
            switch self {
            case .normal, .editing:
                return UIColor.Gray500.cgColor
            case .uncorrectedType:
                return UIColor.Error.cgColor
            }
        }
        
        var clearButtonColor: UIColor? {
            switch self {
            case .normal, .editing:
                return UIColor.Gray500
            case .uncorrectedType:
                return UIColor.Error
            }
        }
    }
    
    var textFieldStatus: CustomTextField = .normal {
        didSet {
            updateBorderColor()
        }
    }
    
    // MARK: - UI Components
    
    private lazy var clearButton: UIButton = {
        let config = UIImage.SymbolConfiguration(scale: .medium)
        let image = UIImage(systemName: "xmark", withConfiguration: config)
        let button = UIButton(type: .system, primaryAction: nil)
        button.configuration = UIButton.Configuration.plain()
        button.setImage(image, for: .normal)
        let buttonInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        button.largeContentImageInsets = buttonInsets
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        button.tintColor = UIColor.Gray500
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeHolder: String) {
        self.init()
        setUI(placeHolder: placeHolder)
    }
}

// MARK: - Extensions

private extension CustomTextField {
    func setUI(placeHolder: String) {
        self.placeholder = "\(placeHolder)"
        self.rightView = clearButton
        self.rightViewMode = .whileEditing
        self.layer.cornerRadius =  24
        self.layer.borderColor = UIColor.Gray500.cgColor
        self.layer.borderWidth = 1
        self.setLeftPadding(amount: 20)
    }
    
    func updateBorderColor() {
        self.layer.borderColor = textFieldStatus.borderColor
        clearButton.tintColor = textFieldStatus.clearButtonColor
    }
    
    @objc func clearButtonTapped() {
        self.text?.removeAll()
        self.textFieldStatus = .normal
    }
}
