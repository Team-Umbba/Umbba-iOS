//
//  NetworkResult.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/03.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
