//
//  UserManager.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/03.
//

import Foundation

final class UserManager {
    static let shared = UserManager()
    
    var accessToken = "accessToken"
    var refreshToken = "refreshToken"
    var fcmToken = "fcmToken"
    
    private init() {}
}
