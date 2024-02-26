//
//  MyPageService.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2/25/24.
//

import Foundation

import Alamofire

final class MyPageService: BaseService {
    
    static let shared = MyPageService()
    
    private override init() {}
}

extension MyPageService {
    
    func getMyPageAPI(completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.myPageURL
        let header: HTTPHeaders = NetworkConstant.hasTokenHeader
        let dataRequest = AF.request(url,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode,
                                                     data,
                                                     MyPageEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
            
        }
    }
}
