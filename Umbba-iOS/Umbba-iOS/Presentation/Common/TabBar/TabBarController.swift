//
//  TabBarController.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/10.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Properties
        
    private let TabBarHeight: CGFloat = 83

    // MARK: - UI Components
    
    private let borderView: UIView = {
        let borderView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.width, height: TabBarHeight))
        borderView.backgroundColor = .clear
        borderView.layer.borderWidth = 1.0  // 테두리의 두께를 설정합니다.
        borderView.layer.borderColor = UIColor.red.cgColor  // 테두리의 색상을 설정합니다.
        return borderView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTabBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        setTabBarHeight()
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
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = TabBarHeight
        tabFrame.origin.y = self.view.frame.size.height - TabBarHeight
        self.tabBar.frame = tabFrame
    }
    
    func setTabBar() {
        let home = makeTabBar(
            viewController: NoticeAlarmViewController(),
            title: "",
            tabBarImg: ImageLiterals.TabBar.icn_home,
            tabBarSelectedImg: ImageLiterals.TabBar.icn_home_selected,
            renderingMode: .alwaysOriginal
        )
        let list = makeTabBar(
            viewController: ViewController(),
            title: "",
            tabBarImg: ImageLiterals.TabBar.icn_list,
            tabBarSelectedImg: ImageLiterals.TabBar.icn_list_selected,
            renderingMode: .alwaysOriginal
        )
        let setting = makeTabBar(
            viewController: SettingViewController(),
            title: "",
            tabBarImg: ImageLiterals.TabBar.icn_setting,
            tabBarSelectedImg: ImageLiterals.TabBar.icn_setting_selected,
            renderingMode: .alwaysOriginal
        )

        let tabs = [home, list, setting]
        self.setViewControllers(tabs, animated: false)
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
    }
}
