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
        let url = URLConstant.mainURL
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
                                                     MainEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func getAnswerAPI(completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.answerURL
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
                                                     AnswerEntity.self)
                print(networkResult)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    //API : 질문에 답변하기
    
    func postAnswerAPI(answer: String,
                       completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.answerURL2
        let header: HTTPHeaders = NetworkConstant.hasTokenHeader
        let body: Parameters = [
            "answer": answer
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
                                                     AnswerEntity2.self)
                print(networkResult)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
}
