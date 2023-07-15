//
//  OnBoardingService.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/16.
//

import Foundation

import Alamofire

final class OnBoardingService: BaseService {
    
    static let shared = OnBoardingService()
    
    private override init() {}
}

extension OnBoardingService {
    func postMatchAPI(
        invite_code: String,
        completion: @escaping (NetworkResult<Any>) -> Void
    ) {
        let url = URLConstant.matchURL
        let header: HTTPHeaders = NetworkConstant.hasTokenHeader
        let body: Parameters = [
            "invite_code": invite_code
        ]
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: body,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode,
                                                     data,
                                                     MatchEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
}
