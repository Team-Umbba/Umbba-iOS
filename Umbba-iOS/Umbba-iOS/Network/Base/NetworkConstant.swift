//
//  NeyworkConstant.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/16.
//

import Foundation

import Alamofire

struct NetworkConstant {
    static let noTokenHeader: HTTPHeaders = ["Content-Type": "application/json"]
    static let hasTokenHeader: HTTPHeaders = ["Content-Type": "application/json",
                                             "Authorization": NetworkConstant.accessToken]
    
    static var accessToken = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE2ODg0NTUxOTcsImV4cCI6MTY4ODQ1NTI1NywidXNlcklkIjoxfQ.72JAVQ0gepU0Juuj2wp_D8tQUH6wd2tX0PKXLyc8su7soxd-gTQBSlfY9oqFAHLgCaxiEwSlzLINCDJERcEncw"
}


