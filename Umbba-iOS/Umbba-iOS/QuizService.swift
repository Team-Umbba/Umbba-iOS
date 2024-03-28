//
//  QuizService.swift
//  Umbba-iOS
//
//  Created by 최영린 on 3/15/24.
//

import Foundation

import Alamofire

final class QuizService: BaseService {
    
    static let shared = QuizService()
    
    private override init() {}
}

extension QuizService {
    
    func getQuizAPI(completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.quizURL
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
                                                     QuizEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
            
        }
    }
    
    func patchQuizAnswerAPI(answer: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.quizAnswerURL
        let header: HTTPHeaders = NetworkConstant.hasTokenHeader
        let body: Parameters = [
            "answer": answer
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
                                                     BlankEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
            
        }
    }
    
    func patchQuizNextAPI(completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.quizNextURL
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
