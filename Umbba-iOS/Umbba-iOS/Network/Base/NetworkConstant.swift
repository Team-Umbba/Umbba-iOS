//
//  NeyworkConstant.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/16.
//

import Foundation

import Alamofire

enum NetworkConstant {
    static var noTokenHeader: HTTPHeaders = ["Content-Type": "application/json"]
    static var hasTokenHeader: HTTPHeaders {
        var headers: HTTPHeaders =
        ["Content-Type": "application/json",
         "Authorization": "Bearer \(UserManager.shared.getAccessToken)"]
        return headers
    }
}
