//
//  UserInfoViewController.swift
//  Umbba-Lab
//
//  Created by 최영린 on 2023/07/06.
//

import UIKit

final class UserInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    var isReceiver: Bool = false
    
    // MARK: - UI Components
    
    lazy var userInfoView = UserInfoView()
    lazy var userInfoStackView = userInfoView.infoStackView
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = userInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        setupKeyboardEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupKeyboardEvent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardEvent()
    }
}

// MARK: - Extensions

extension UserInfoViewController {
    func setUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    func setDelegate() {
        dismissKeyboard()
        userInfoView.navigationdelegate = self
        userInfoView.nextDelegate = self
    }
    
    private func setupKeyboardEvent() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
    }
    
    private func removeKeyboardEvent() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func viewDidTap() {
        view.endEditing(true)
    }
    
    @objc
    private func keyboardWillShow(_ sender: Notification) {
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentResponder as? UITextField else { return }
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let keyboardOverlap = textFieldBottomY - keyboardTopY
            view.frame.origin.y = -keyboardOverlap - 40
        }
    }
    
    @objc
    private func keyboardWillHide(_ sender: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
}

extension UserInfoViewController: NavigationBarDelegate {
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {
        
    }
}

extension UserInfoViewController: NextButtonDelegate {
    func nextButtonTapped() {
        if isReceiver {
            let questViewController =  QuestViewController()
            self.navigationController?.pushViewController(questViewController, animated: true)
            questViewController.isReceiver = true
        } else {
            self.navigationController?.pushViewController(FamilyInfoViewController(), animated: true)
        }
    }
}
