//
//  TabBarController.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/10.
//

import UIKit

import FirebaseDynamicLinks

final class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    private let TabBarHeight: CGFloat = 51
    
    var upperLineView: UIView = UIView()
    
    // MARK: - UI Components
    
    private let defaultLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.Gray300
        return lineView
    }()
    
    // MARK: - Life Cycles
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.addTabbarIndicatorView(index: self.selectedIndex)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.addTabbarIndicatorView(index: 0, isFirstTime: true)
        }
        
        setLayout()
        setDelegate()
        setTabBar()
        addObserver()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setTabBarHeight()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Extensions

private extension TabBarController {
    
    func makeTabBar(viewController: UIViewController,
                    title: String,
                    tabBarImg: UIImage,
                    tabBarSelectedImg: UIImage,
                    renderingMode: UIImage.RenderingMode) -> UIViewController {
        
        let tab = UINavigationController(rootViewController: viewController)
        tab.isNavigationBarHidden = true
        tab.tabBarItem = UITabBarItem(title: title,
                                      image: tabBarImg.withRenderingMode(renderingMode),
                                      selectedImage: tabBarSelectedImg.withRenderingMode(renderingMode))
        return tab
    }
    
    func setTabBarHeight() {
        if let tabBar = self.tabBarController?.tabBar {
            let safeAreaBottomInset = self.view.safeAreaInsets.bottom
            let tabBarHeight = tabBar.bounds.height
            let newTabBarFrame = CGRect(x: tabBar.frame.origin.x, y: tabBar.frame.origin.y - safeAreaBottomInset, width: tabBar.frame.width, height: tabBarHeight + safeAreaBottomInset)
            tabBar.frame = newTabBarFrame
        }
    }
    
    func addTabbarIndicatorView(index: Int, isFirstTime: Bool = false) {
        guard let tabView = tabBar.items?[index].value(forKey: "view") as? UIView else {
            return
        }
        
        if !isFirstTime {
            upperLineView.removeFromSuperview()
        }
        upperLineView = UIView(frame: CGRect(x: tabView.frame.minX - 1, y: tabView.frame.minY - 1, width: tabView.frame.size.width + 2, height: 1))
        upperLineView.backgroundColor = UIColor.Primary500
        
        tabBar.addSubview(upperLineView)
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(showInvitePopUP), name: Notification.Name("share"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showDisconnectPopUP), name: Notification.Name("disconnect"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showLoadingView), name: Notification.Name("show"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideLoadingView), name: Notification.Name("hide"), object: nil)
    }
    
    func setLayout() {
        tabBar.addSubview(defaultLineView)
        
        defaultLineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    func setDelegate() {
        self.delegate = self
    }
    
    func setTabBar() {
        let home = makeTabBar(
            viewController: MainViewController(),
            title: "",
            tabBarImg: ImageLiterals.TabBar.icn_home,
            tabBarSelectedImg: ImageLiterals.TabBar.icn_home_selected,
            renderingMode: .alwaysOriginal
        )
        let list = makeTabBar(
            viewController: ArchivingViewController(),
            title: "",
            tabBarImg: ImageLiterals.TabBar.icn_list,
            tabBarSelectedImg: ImageLiterals.TabBar.icn_list_selected,
            renderingMode: .alwaysOriginal
        )
        let mypage = makeTabBar(
            viewController: MyPageViewController(),
            title: "",
            tabBarImg: ImageLiterals.TabBar.icn_setting,
            tabBarSelectedImg: ImageLiterals.TabBar.icn_setting_selected,
            renderingMode: .alwaysOriginal
        )
        
        let tabs = [home, list, mypage]
        self.setViewControllers(tabs, animated: false)
        tabBar.backgroundColor = .White500
        tabBar.isTranslucent = false
    }
    
    @objc func showInvitePopUP(notification: Notification) {
        guard let inviteCode = notification.userInfo?["inviteCode"] as? String else { return }
        guard let inviteUserName = notification.userInfo?["inviteUserName"] as? String else { return }
        guard let installURL = notification.userInfo?["installURL"] as? String else { return }
        self.makeAlert(inviteCode: inviteCode, inviteUsername: inviteUserName, installURL: installURL) {
            self.share(inviteCode: inviteCode, inviteUserName: inviteUserName)
        }
    }
    
    @objc func showDisconnectPopUP() {
        self.makeAlert(alertType: .disconnectAlert) {}
    }
    
    @objc func showLoadingView() {
        LoadingView.shared.show(self.view)
    }
    
    @objc func hideLoadingView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            LoadingView.shared.hide {
            }
        }
    }
    
    func share(inviteCode: String, inviteUserName: String) {
        guard let inviteCode = inviteCode.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let link = URL(string: "https://umbba.page.link/umbba?code=" + inviteCode) else { return }
        let dynamicLinksDomainURIPrefix = "https://umbba.page.link"
        
        let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix)
        linkBuilder?.iOSParameters = DynamicLinkIOSParameters(bundleID: "org.umbba.Umbba-iOS")
        linkBuilder?.iOSParameters?.appStoreID = "6450973870"
        linkBuilder?.androidParameters = DynamicLinkAndroidParameters(packageName: "com.ubcompany.umbba_android")
       
        guard let longDynamicLink = linkBuilder?.url else { return }
        
        linkBuilder?.shorten { shortURL, warnings, error in
          guard let shortURL = shortURL else { return }
          self.showLinkShare(inviteCode: inviteCode, inviteUserName: inviteUserName, url: shortURL)
        }
    }
    
    private func showLinkShare(inviteCode: String, inviteUserName: String, url: URL?) {
        guard let url = url?.absoluteString else { return }
        let inviteText = "'\(inviteUserName)' 으로부터 초대가 왔어요💌\n\n당신의 가장 오래된 기억이 무엇인가요?\n과거로 떠나 함께 추억을 나누고, 공감대를 형성해보세요.\n\n어플 설치 후 하단의 초대코드를 입력해, 상대방과 연결하세요\n\n초대코드 : \(inviteCode)\n\n\(url)"
        
        let activityVC = UIActivityViewController(activityItems: [inviteText], applicationActivities: nil)
        
        activityVC.completionWithItemsHandler = { [weak self] (activityType, completed, _, error) in
            if completed {
                print("초대코드 공유 완료")
            }
            if let error = error {
                print("초대코드 공유 오류: \(error.localizedDescription)")
            }
            self?.dismiss(animated: true, completion: nil)
        }
        
        present(activityVC, animated: true, completion: nil)
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let selectedNavigationController = viewController as? UINavigationController,
           let selectedViewController = selectedNavigationController.viewControllers.first {
            if selectedViewController is MainViewController {
                if let mainViewController = selectedViewController as? MainViewController {
                    mainViewController.isShow = false
                }
            }
        }
        addTabbarIndicatorView(index: selectedIndex)
    }
}
