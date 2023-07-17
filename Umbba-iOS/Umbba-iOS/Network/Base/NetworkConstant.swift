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
    
    static var accessToken = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE2ODk0ODg2NTksImV4cCI6MTY4OTU3NTA1OSwidXNlcklkIjoxNH0.LIfy9DlZ6eQZrakydBDPrmBMXJW3JQNNei8ceDwgijp6uQt-5XI03aDiJ9_dNTgQLCNupMNR83ib6vLVLpiz7A"
}
