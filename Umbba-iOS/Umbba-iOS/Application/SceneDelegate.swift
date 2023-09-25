//
//  SceneDelegate.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/03.
//

import UIKit

import AuthenticationServices
import KakaoSDKAuth
import FirebaseDynamicLinks

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if AuthApi.isKakaoTalkLoginUrl(url) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let userActivity = connectionOptions.userActivities.first {
            self.scene(scene, continue: userActivity)
        }
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: LottieViewController())
        if let navigationController = window?.rootViewController as? UINavigationController {
            navigationController.isNavigationBarHidden = true
        }
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        if let url = userActivity.webpageURL {
            let handled = DynamicLinks.dynamicLinks().handleUniversalLink(url) { dynamicLink, error in
                var rootViewController: UIViewController?
                
                if UserManager.shared.hasAccessToken {
                    if UserManager.shared.getIsMatch {
                        if UserManager.shared.haveUserName {
                            rootViewController = TabBarController()
                        } else {
                            let animationViewController = AnimationViewController()
                            animationViewController.isReceiver = true
                            rootViewController = animationViewController
                        }
                    } else {
                        rootViewController = InviteViewController()
                    }
                } else {
                    rootViewController = LoginViewController()
                }
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let keyWindow = windowScene.windows.first else {
                    return
                }
                if let rootVC = rootViewController {
                    keyWindow.rootViewController = UINavigationController(rootViewController: rootVC)
                    if let navigationController = keyWindow.rootViewController as? UINavigationController {
                        navigationController.isNavigationBarHidden = true
                    }
                }
            }
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: UserManager.shared.appleUserIdentifier ?? "") { (credentialState, error) in
            switch credentialState {
            case .authorized:
                print("authorized")
            case .revoked:
                print("revoked")
            case .notFound:
                print("notFound")
            default:
                break
            }
        }
        let center = UNUserNotificationCenter.current()
        
        center.getNotificationSettings { settings in
            print(settings)
            switch settings.alertSetting {
            case .enabled:
                UserManager.shared.updateAllowAlarm(true)
            default:
                UserManager.shared.updateAllowAlarm(false)
            }
            NotificationCenter.default.post(name: NSNotification.Name("Alert"), object: nil)
        }
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
}
