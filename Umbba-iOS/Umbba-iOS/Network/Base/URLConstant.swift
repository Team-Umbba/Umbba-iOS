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
    static let inviteURL = baseURL + "/onboard/invite"
    static let receiveURL = baseURL + "/onboard/receive"
    
    // MARK: - Home URL
    
    static let mainURL = baseURL + "/home"
    
    static let answerURL = baseURL + "/qna/today"
    static let answerURL2 = baseURL + "/qna/answer"
    static let restartURL = baseURL + "/qna/restart"
    
    static let caseURL = baseURL + "/home/case"
    
    // MARK: - Archiving URL
 
    static let archivingURL = baseURL + "/qna/list"
    static let qnaURL = baseURL + "/qna"
    
    // MARK: - MyPage URL
       
    static let myPageURL =  baseURL + "/user/me"
    
    // MARK: - Quiz URL
    
    static let quizURL = baseURL + "/closer/today"
    static let quizAnswerURL =  baseURL + "/closer/answer"
    static let quizNextURL = baseURL + "/closer/next"
    
    // MARK: - Record URL
       
    static let albumURL =  baseURL + "/album"
    static let albumImageURL = baseURL + "/album/image"
    static let albumDeleteURL = baseURL + "/album/"

}
