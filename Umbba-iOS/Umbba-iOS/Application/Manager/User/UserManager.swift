//
//  UserManager.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/20.
//

import Foundation

final class UserManager {
    static let shared = UserManager()
    
    @UserDefaultWrapper<String>(key: "socialToken") private(set) var socialToken
    
    @UserDefaultWrapper<String>(key: "accessToken") private(set) var accessToken
    @UserDefaultWrapper<String>(key: "refreshToken") private(set) var refreshToken
    @UserDefaultWrapper<String>(key: "fcmToken") private(set) var fcmToken
    @UserDefaultWrapper<Bool>(key: "allowAlarm") private(set) var allowAlarm
    @UserDefaultWrapper<String>(key: "userIdentifier") private(set) var appleUserIdentifier
    
    var hasAccessToken: Bool { return self.accessToken != nil }
    
    var getSocialToken: String { return self.socialToken ?? "" }
    var getAccessToken: String { return self.accessToken ?? "" }
    var getFcmToken: String { return self.fcmToken ?? "" }
    var getAllowAlarm: Bool { return self.allowAlarm ?? true }
    
    private init() {}
}

// MARK: - Methods

extension UserManager {
    func updateToken(_ accessToken: String, _ refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
    func updateFcmToken( _ fcmToken: String) {
        self.fcmToken = fcmToken
    }
    
    func updateAllowAlarm(_ allowAlarm: Bool) {
        self.allowAlarm = allowAlarm
    }

    func setUserIdForApple(userId: String) {
        self.appleUserIdentifier = userId
    }
}
