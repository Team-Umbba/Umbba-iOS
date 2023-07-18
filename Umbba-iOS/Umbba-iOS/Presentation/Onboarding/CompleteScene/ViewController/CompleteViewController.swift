//
//  CompleteViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/09.
//

import UIKit

final class CompleteViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let completeView = CompleteView()
    //    private let imageView = completeView.backgroundImageView
    
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
    }
    
    func updateUI() {
        self.completeView.backgroundImageView.image = ImageLiterals.Onboarding.img_arrive
        self.completeView.completeTitleLabel.textColor = .UmbbaBlack
        self.completeView.navigationBarView.leftButton.tintColor = .UmbbaBlack
    }
}

extension CompleteViewController: NavigationBarDelegate {
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {
        
    }
}

extension CompleteViewController: NextButtonDelegate {
    func nextButtonTapped() {
//        self.postInviteAPI(user_info: UserData.shared.userInfo,
//                           is_invitor_child: UserData.shared.isInvitorChild,
//                           relation_info: UserData.shared.relationInfo,
//                           push_time: UserData.shared.pushTime,
//                           onboarding_answer_list: UserData.shared.onboardingAnswerList)
        self.patchReceiveAPI(user_info: UserData.shared.userInfo,
                             onboarding_answer_list: UserData.shared.onboardingAnswerList)
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
            print(NetworkResult)
            switch NetworkResult {
            case .success(let data):
                if let data = data as? GenericResponse<InviteEntity> {
                    print(data)
                    self.navigationController?.pushViewController(TabBarController(), animated: true)
                }
            default:
                break
            }
        }
    }
    
    func patchReceiveAPI(user_info: User,
                         onboarding_answer_list: [String]) {
        OnBoardingService.shared.patchRecieveAPI(user_Info: user_info,
                                                 onboarding_answer_list: onboarding_answer_list) { NetworkResult in
            print(NetworkResult)
            switch NetworkResult {
            case .success(let data):
                if let data = data as? GenericResponse<ReceiveEntity> {
                    print(data)
                    self.navigationController?.pushViewController(TabBarController(), animated: true)
                }
            default:
                break
            }
        }
    }
}
