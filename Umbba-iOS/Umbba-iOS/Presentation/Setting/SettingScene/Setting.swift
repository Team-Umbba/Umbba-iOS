//
//  Setting.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/03.
//

import UIKit

struct Setting {
    let title: String
}

extension Setting {
    
    static func section0() -> [Setting] {
        return [Setting(title: "계정 관리")
        ]
    }
    
    static func section1() -> [Setting] {
        return [Setting(title: "About 엄빠도 어렸다"),
                Setting(title: "이용약관"),
                Setting(title: "공지사항")
        ]
    }
}
