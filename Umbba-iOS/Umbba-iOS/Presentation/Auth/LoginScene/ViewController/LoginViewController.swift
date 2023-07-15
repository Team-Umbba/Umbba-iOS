//
//  LoginViewController.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/05.
//

import UIKit

import KakaoSDKUser

final class LoginViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let loginView = LoginView()
    
    override func loadView() {
        super.loadView()
        self.view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
    }

}

// MARK: - Extensions

extension LoginViewController {
    func setDelegate() {
        loginView.loginDelegate = self
    }
}

extension LoginViewController: LoginDelegate {
    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if error != nil {
                    self.showKakaoLoginFailMessage()
                } else {
                    if let accessToken = oauthToken?.accessToken {
                        print("TOKEN", accessToken)
                        self.postSocialLoginData(socialToken: accessToken, socialType: "KAKAO")
                    }
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if error != nil {
                    self.showKakaoLoginFailMessage()
                } else {
                    if let accessToken = oauthToken?.accessToken {
                        self.postSocialLoginData(socialToken: accessToken, socialType: "KAKAO")
                    }
                    self.presentToAssignView()
                }
            }
        }
    }
    
    func showKakaoLoginFailMessage() {
        print("🍔🍔🍔🍔🍔")
    }
    
    func postSocialLoginData(socialToken: String, socialType: String) {
        print("🌐🌐🌐🌐")
    }
    
    func presentToAssignView() {
        self.navigationController?.pushViewController(AssignViewController(), animated: false)
    }
}
