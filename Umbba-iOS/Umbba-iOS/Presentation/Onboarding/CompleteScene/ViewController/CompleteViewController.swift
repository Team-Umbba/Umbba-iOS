//
//  CompleteViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/09.
//

import UIKit

final class CompleteViewController: UIViewController {
    
    // MARK: - Properties
    
    var isReceiver: Bool = false
    
    // MARK: - UI Components
    
    private let completeView = CompleteView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = completeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            UIView.transition(with: self.completeView, duration: 1.0, options: .transitionCrossDissolve, animations: {
                self.updateUI()
            }, completion: nil)
        }
        setDelegate()
    }
}

// MARK: - Extensions

private extension CompleteViewController {
    
    func setDelegate() {
        completeView.navigationdelegate = self
        completeView.nextDelegate = self
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func updateUI() {
        self.completeView.completeTitleLabel.text = I18N.Onboarding.completeTitle
        if SizeLiterals.Screen.deviceRatio > 0.5 {
            self.completeView.backgroundImageView.image = ImageLiterals.Onboarding.img_se_arrive
        } else {
            self.completeView.backgroundImageView.image = ImageLiterals.Onboarding.img_arrive
        }
        self.completeView.completeTitleLabel.textColor = .UmbbaBlack
        self.completeView.navigationBarView.leftButton.tintColor = .UmbbaBlack
    }
}

extension CompleteViewController: NavigationBarDelegate {
    @objc
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {
        
    }
}

extension CompleteViewController: UIGestureRecognizerDelegate {
    func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        view.addGestureRecognizer(tapGesture)
    }
}

extension CompleteViewController: NextButtonDelegate {
    func nextButtonTapped() {
        if isReceiver {
            self.navigationController?.pushViewController(TabBarController(), animated: true)
        } else {
            UserManager.shared.updateUserName(UserData.shared.userInfo.name)
            self.postInviteAPI(user_info: UserData.shared.userInfo,
                               is_invitor_child: UserData.shared.isInvitorChild,
                               relation_info: UserData.shared.relationInfo,
                               push_time: UserData.shared.pushTime,
                               onboarding_answer_list: UserData.shared.onboardingAnswerList)
        }
    }
}

// MARK: - Network

extension CompleteViewController {
    func postInviteAPI(user_info: User,
                       is_invitor_child: Bool,
                       relation_info: String,
                       push_time: String,
                       onboarding_answer_list: [String]) {
        OnBoardingService.shared.postInviteAPI(user_Info: user_info,
                                               is_invitor_child: is_invitor_child,
                                               relation_Info: relation_info,
                                               push_time: push_time,
                                               onboarding_answer_list: onboarding_answer_list) { NetworkResult in
            switch NetworkResult {
            case .success:
                self.navigationController?.pushViewController(TabBarController(), animated: true)
            case .requestErr, .serverErr:
                self.makeAlert(title: "오류가 발생했습니다", message: "다시 시도해주세요")
            default:
                break
            }
        }
    }
}
