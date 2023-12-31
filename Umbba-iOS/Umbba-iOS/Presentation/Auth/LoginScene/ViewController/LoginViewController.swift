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
    private var appleEntity: LoginEntity?
    
    // MARK: - UI Components
    
    private let loginView = LoginView()
    
    static var isMatch: Bool = false
    
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
        AuthService.shared.postLoginAPI(social_platform: socialPlatform, social_token: socialToken, fcm_token: UserManager.shared.getFcmToken) { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<LoginEntity> {
                    switch socialPlatform {
                    case "KAKAO":
                        if let kakaoData = data.data {
                            self.kakaoEntity = kakaoData
                            self.checkKakaoUser()
                        }
                    case "APPLE":
                        if let appleData = data.data {
                            self.appleEntity = appleData
                            self.checkAppleUser()
                        }
                    default:
                        break
                    }
                    
                }
            case .requestErr, .serverErr:
                self.makeAlert(title: "오류가 발생했습니다", message: "다시 시도해주세요")
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
                        self.postLoginAPI(socialToken: accessToken, socialPlatform: "KAKAO")
                    }
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if error != nil {
                    self.showKakaoLoginFailMessage()
                } else {
                    if let accessToken = oauthToken?.accessToken {
                        self.postLoginAPI(socialToken: accessToken, socialPlatform: "KAKAO")
                    }
                }
            }
        }
    }
    
    func showKakaoLoginFailMessage() {
        makeAlert(title: I18N.Auth.kakaoFailMessage, message: "")
    }
    
//    func postSocialLoginData(socialToken: String, socialType: String) {
//        postLoginAPI(socialToken: socialToken, socialPlatform: socialType)
//    }
    
    func checkKakaoUser() {
        guard let kakaoEntity = kakaoEntity else { return }
        UserManager.shared.updateToken(kakaoEntity.tokenDto.accessToken, kakaoEntity.tokenDto.refreshToken)
        UserManager.shared.updateUserName(kakaoEntity.username ?? "")
        
        if kakaoEntity.username != nil {
            presentToMainView()
        } else {
            presentToAssignView()
        }
    }
    
    func checkAppleUser() {
        guard let appleEntity = appleEntity else { return }
        UserManager.shared.updateToken(appleEntity.tokenDto.accessToken, appleEntity.tokenDto.refreshToken)
        UserManager.shared.updateUserName(appleEntity.username ?? "")
        LoginViewController.isMatch = appleEntity.isMatchFinish ?? false
        
        if appleEntity.username != nil {
            presentToMainView()
        } else {
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
    
//    func postSocialLoginAppleData(socialToken: String, socialType: String) {
//        postSocialLoginData(socialToken: socialToken, socialType: socialType)
//    }
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
            UserManager.shared.setUserIdForApple(userId: userIdentifier)
            let identityToken = appleIDCredential.identityToken
            let tokenString = String(data: identityToken!, encoding: .utf8)
            if let token = tokenString {
                postLoginAPI(socialToken: token, socialPlatform: "APPLE")
            }
        default:
            break
        }
    }
}
