//
//  ImageLiterals.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/03.
//

import UIKit

enum ImageLiterals {
    enum Common {
        static var img_umbbaLogo: UIImage { .load(name: "umbbaLogo") }
        static var icn_exit: UIImage { .load(name: "exit") }
    }
    
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
    
    enum Onboarding {
        static var img_arrive: UIImage { .load(name: "arrive") }
        static var img_depart: UIImage { .load(name: "depart") }
    }
    
    enum Auth {
        static var icn_check_circle: UIImage { .load(name: "circle_check") }
        static var icn_apple: UIImage { .load(name: "appleLogo") }
        static var icn_kakao: UIImage { .load(name: "kakaoLogo") }
        static var img_login: UIImage { .load(name: "login_img") }
        static var img_start: UIImage { .load(name: "start_img") }
        static var SE_login: UIImage { .load(name: "SE_login") }
        static var SE_start: UIImage { .load(name: "SE_start") }
    }
    
    enum Home {
        static var main_1: UIImage { .load(name: "home1") }
        static var main_2: UIImage { .load(name: "home2") }
        static var main_3: UIImage { .load(name: "home3") }
        static var main_4: UIImage { .load(name: "home4") }
        static var main_5: UIImage { .load(name: "home5") }
        static var SE_home1: UIImage { .load(name: "SE_home1") }
        static var SE_home2: UIImage { .load(name: "SE_home2") }
        static var SE_home3: UIImage { .load(name: "SE_home3") }
        static var SE_home4: UIImage { .load(name: "SE_home4") }
        static var SE_home5: UIImage { .load(name: "SE_home5") }
        static var icn_disconnect: UIImage { .load(name: "icn_disconnect") }
    }
    
    enum Archiving {
        static var list_img1: UIImage { .load(name: "list_img1") }
        static var list_img2: UIImage { .load(name: "list_img2") }
        static var list_img3: UIImage { .load(name: "list_img3") }
        static var list_img4: UIImage { .load(name: "list_img4") }
        static var list_img5: UIImage { .load(name: "list_img5") }
        static var list_se_img1: UIImage { .load(name: "se_list_img1") }
        static var list_se_img2: UIImage { .load(name: "se_list_img2") }
        static var list_se_img3: UIImage { .load(name: "se_list_img3") }
        static var list_se_img4: UIImage { .load(name: "se_list_img4") }
        static var list_se_img5: UIImage { .load(name: "se_list_img5") }
    }
}
