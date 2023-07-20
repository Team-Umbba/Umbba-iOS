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
        completion: @escaping (NetworkResult<Any>) -> Void) {
            let url = URLConstant.matchURL
            let header: HTTPHeaders = NetworkConstant.hasTokenHeader
            let body: Parameters = [
                "invite_code": invite_code
            ]
            let dataRequest = AF.request(url,
                                         method: .patch,
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
    
    func postInviteAPI(
        user_Info: User,
        is_invitor_child: Bool,
        relation_Info: String,
        push_time: String,
        onboarding_answer_list: [String],
        completion: @escaping (NetworkResult<Any>) -> Void) {
            let url = URLConstant.inviteURL
            let header: HTTPHeaders = NetworkConstant.hasTokenHeader
            let body: Parameters = [
                "user_info": [
                    "name": user_Info.name,
                    "gender": user_Info.gender,
                    "born_year": user_Info.bornYear
                ] as [String: Any],
                "is_invitor_child": is_invitor_child,
                "relation_info": relation_Info,
                "push_time": push_time,
                "onboarding_answer_list": onboarding_answer_list
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
                    print("🍎🍎🍎🍎🍎🍎🍎초대 하는 측 service 쪽🍎🍎🍎🍎🍎🍎🍎🍎")
                    print("data")
                    guard let data = response.data else { return }
                    let networkResult = self.judgeStatus(by: statusCode,
                                                         data,
                                                         InviteEntity.self)
                    completion(networkResult)
                case .failure:
                    completion(.networkFail)
                }
            }
        }
    
    func patchRecieveAPI(
        user_Info: User,
        onboarding_answer_list: [String],
        completion: @escaping (NetworkResult<Any>) -> Void) {
            let url = URLConstant.receiveURL
            let header: HTTPHeaders = NetworkConstant.hasTokenHeader
            let body: Parameters = [
                "user_info": [
                    "name": user_Info.name,
                    "gender": user_Info.gender,
                    "born_year": user_Info.bornYear
                ] as [String: Any],
                "onboarding_answer_list": onboarding_answer_list
            ]
            let dataRequest = AF.request(url,
                                         method: .patch,
                                         parameters: body,
                                         encoding: JSONEncoding.default,
                                         headers: header)
            dataRequest.responseData { response in
                switch response.result {
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let data = response.data else { return }
                    print("🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎")
                    print(data)
                    print("🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎")
                    let networkResult = self.judgeStatus(by: statusCode,
                                                         data,
                                                         ReceiveEntity.self)
                    completion(networkResult)
                case .failure:
                    completion(.networkFail)
                }
            }
        }
}
