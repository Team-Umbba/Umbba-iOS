//
//  LoginViewController.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/05.
//

import UIKit

import KakaoSDKUser
import AuthenticationServices

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private var kakaoEntity: LoginEntity?
    
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

// MARK: - Network

extension LoginViewController {
    func postLoginAPI(socialToken: String, socialPlatform: String) {
        AuthService.shared.postLoginAPI(social_platform: socialPlatform, social_token: socialToken, fcm_token: "z") { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<LoginEntity> {
                    dump(data)
                    if let kakaoData = data.data {
                        self.kakaoEntity = kakaoData
                        self.checkUser()
                    }
                }
            default:
                break
            }
        }
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
                }
            }
        }
    }
    
    func showKakaoLoginFailMessage() {
        print("🍔🍔🍔🍔🍔")
    }
    
    func postSocialLoginData(socialToken: String, socialType: String) {
        postLoginAPI(socialToken: socialToken, socialPlatform: socialType)
    }
    
    func checkUser() {
        guard let kakaoEntity = kakaoEntity else { return }
        
        if kakaoEntity.username != nil {
            presentToMainView()
        } else {
            UserManager.shared.accessToken = kakaoEntity.tokenDto.accessToken
            UserManager.shared.refreshToken = kakaoEntity.tokenDto.refreshToken
            UserManager.shared.fcmToken = kakaoEntity.fcmToken
            NetworkConstant.accessToken = "Bearer \(kakaoEntity.tokenDto.accessToken)"
            presentToAssignView()
        }
    }
    
    func presentToAssignView() {
        self.navigationController?.pushViewController(AssignViewController(), animated: false)
    }
    
    func presentToMainView() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first else {
            return
        }
        keyWindow.rootViewController = TabBarController()
    }
    
    func appleLogin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = []
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func postSocialLoginAppleData(socialToken: String, socialType: String) {
        print("💛💛💛💛💛")
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            print("User ID : \(userIdentifier)")
            let identityToken = appleIDCredential.identityToken
            let tokenString = String(data: identityToken!, encoding: .utf8)
            print(tokenString ?? "defaultstring")
            if let token = tokenString {
                postSocialLoginAppleData(socialToken: token, socialType: "APPLE")
            }
        default:
            break
        }
    }
}
