//
//  MainItem.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/14.
//

import UIKit

struct MainItem {
    let section: String
    let topic: String
    let count: Int
}

extension MainItem {
    
    static func mainDummy() -> MainItem {
        return MainItem(section: "어린시절", topic: "가장 오래된 기억", count: 1)
    }
}
