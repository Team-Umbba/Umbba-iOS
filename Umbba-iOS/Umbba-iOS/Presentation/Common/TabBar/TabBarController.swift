//
//  TabBarController.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/10.
//

import UIKit

class TabBarController: UITabBarController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
           self.addTabbarIndicatorView(index: 0, isFirstTime: true)
        }
        
        setLayout()
        setDelegate()
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
    }
    
    func setLayout() {
        tabBar.addSubviews(defaultLineView, upperLineView)
        
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

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        addTabbarIndicatorView(index: self.selectedIndex)
    }
}
