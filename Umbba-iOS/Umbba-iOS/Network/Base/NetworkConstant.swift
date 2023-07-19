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
                                              "Authorization": "Bearer \(UserManager.shared.getAccessToken)"]
}
