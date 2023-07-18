//
//  URLConstant.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/16.
//

import Foundation

enum URLConstant {
    
    // MARK: - Base URL
    
    static let baseURL = Config.baseURL
    
    // MARK: - Auth URL
    
    static let loginURL = baseURL + "/login"
    static let logoutURL = baseURL + "/log-out"
    static let signoutURL = baseURL + "/sign-out"
    
    // MARK: - OnBoarding URL
    
    static let matchURL = baseURL + "/onboard/match"
    
    // MARK: - Home URL
    
    static let mainURL = baseURL + "/home"
    
    static let answerURL = baseURL + "/qna/today"
    static let answerURL2 = baseURL + "/qna/answer"
    
    static let caseURL = baseURL + "/home/case"
    
    // MARK: - Archiving URL
 
    static let archivingURL = baseURL + "/qna/list"
    static let qnaURL = baseURL + "/qna"
}
