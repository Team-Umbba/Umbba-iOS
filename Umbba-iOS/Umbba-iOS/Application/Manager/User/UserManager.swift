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
    @UserDefaultWrapper<String>(key: "userName") private(set) var userName
    @UserDefaultWrapper<Bool>(key: "isMatch") private(set) var isMatch
    
    var hasAccessToken: Bool { return self.accessToken != nil }
    
    var getSocialToken: String { return self.socialToken ?? "" }
    var getAccessToken: String { return self.accessToken ?? "" }
    var getFcmToken: String { return self.fcmToken ?? "" }
    var getIsMatch: Bool { return self.isMatch ?? false }
    var getAllowAlarm: Bool { return self.allowAlarm ?? true }
    
    var haveUserName: Bool {
        if userName == "" {
            return false
        } else if userName == nil {
            return false
        } else {
            return true
        }
    }
    
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

    func updateUserName(_ userName: String) {
        self.userName = userName
    }
    
    func updateIsMatch(_ isMatch: Bool) {
        self.isMatch = isMatch
    }

    func setUserIdForApple(userId: String) {
        self.appleUserIdentifier = userId
    }
    
    func clearAll() {
//        UserDefaults.standard.removeObject(forKey: self.getAccessToken)
//        UserDefaults.standard.removeObject(forKey: self.refreshToken ?? "")
//        UserDefaults.standard.removeObject(forKey: self.socialToken ?? "")
//        UserDefaults.standard.removeObject(forKey: self.appleUserIdentifier ?? "")
//        self.isMatch = false
        self.accessToken = nil
        self.refreshToken = nil
        self.socialToken = nil
        self.appleUserIdentifier = nil
        self.isMatch = false
    }
    
    func clearData() {
//        UserDefaults.standard.removeObject(forKey: self.getAccessToken)
//        UserDefaults.standard.removeObject(forKey: self.refreshToken ?? "")
//        UserDefaults.standard.removeObject(forKey: self.socialToken ?? "")
//        UserDefaults.standard.removeObject(forKey: self.appleUserIdentifier ?? "")
//        self.isMatch = false
        self.accessToken = nil
        self.refreshToken = nil
        self.socialToken = nil
        self.appleUserIdentifier = nil
    }
}
