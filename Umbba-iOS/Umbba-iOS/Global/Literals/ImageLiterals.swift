//
//  ImageLiterals.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/03.
//

import UIKit

enum ImageLiterals {
    enum NavigationBar {
        static var icn_back: UIImage { .load(name: "back") }
        static var icn_check: UIImage { .load(name: "check") }
    }
    
    enum TabBar {
        static var icn_home: UIImage { .load(name: "home_default") }
        static var icn_home_selected: UIImage { .load(name: "home_active") }
        static var icn_list: UIImage { .load(name: "list_default") }
        static var icn_list_selected: UIImage { .load(name: "list_active") }
        static var icn_setting: UIImage { .load(name: "setting_default") }
        static var icn_setting_selected: UIImage { .load(name: "setting_active") }
    }
}
