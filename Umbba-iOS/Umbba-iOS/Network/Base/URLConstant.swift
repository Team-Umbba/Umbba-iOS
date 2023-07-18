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
    
    // MARK: - OnBoarding URL
    
    static let matchURL = baseURL + "/onboard/match"
    static let inviteURL = baseURL + "/onboard/invite"
    static let receiveURL = baseURL + "/onboard/receive"
    
    // MARK: - Home URL
    
    static let mainURL = baseURL + "/home"
    
    static let answerURL = baseURL + "/qna/today"
    static let answerURL2 = baseURL + "/qna/answer"
    
    static let caseURL = baseURL + "/home/case"
    
    // MARK: - Archiving URL
 
    static let archivingURL = baseURL + "/qna/list"
}
