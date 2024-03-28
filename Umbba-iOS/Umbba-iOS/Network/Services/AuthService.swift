//
//  AuthService.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/03.
//

import Foundation

import Alamofire

final class AuthService: BaseService {
    
    static let shared = AuthService()
    
    private override init() {}
}

extension AuthService {
    func postLoginAPI(
        social_platform: String,
        social_token: String,
        fcm_token: String,
        completion: @escaping (NetworkResult<Any>) -> Void) {
            let url = URLConstant.loginURL
            let header: HTTPHeaders = [
                "Content-Type": "application/json",
                "Authorization": social_token]
            let body: Parameters = [
                "social_platform": social_platform,
                "fcm_token": fcm_token
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
                                                         LoginEntity.self)
                    completion(networkResult)
                case .failure:
                    completion(.networkFail)
                }
            }
        }
    
    func patchLogOutAPI(completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.logoutURL
        let header: HTTPHeaders = NetworkConstant.hasTokenHeader
        let dataRequest = AF.request(url,
                                     method: .patch,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode,
                                                     data,
                                                     BlankEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func patchSignOutAPI(completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.signoutURL
        let header: HTTPHeaders = NetworkConstant.hasTokenHeader
        let dataRequest = AF.request(url,
                                     method: .patch,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode,
                                                     data,
                                                     BlankEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
}
