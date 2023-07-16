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
    
    static var accessToken = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE2ODk0NTUzMTIsImV4cCI6MTY4OTU0MTcxMiwidXNlcklkIjozfQ.CeC1KH56TXSCzs6B0fX0jkt8oBf-6BK94W8zGp1NzFu16U4EUZtYWUpeiJxsSS5jq32nYBEQeTnxUlMk3CAPKw"
}
