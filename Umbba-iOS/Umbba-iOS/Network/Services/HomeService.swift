//
//  HomeService.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/16.
//

import Foundation

import Alamofire

final class HomeService: BaseService {
    
    static let shared = HomeService()
    
    private override init() {}
}

extension HomeService {
    func getHomeAPI(completion: @escaping (NetworkResult<Any>) -> Void) {
        
    }
}
