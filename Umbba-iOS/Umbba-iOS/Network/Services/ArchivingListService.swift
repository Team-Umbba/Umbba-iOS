//
//  ArchivingListService.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/16.
//

import Foundation

import Alamofire

final class ArchivingListService: BaseService {
    
    static let shared = ArchivingListService()
    
    private override init() {}
}

extension ArchivingListService {
    
    func getArchivingListAPI(sectionId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.archivingURL + "/\(sectionId)"
        let header: HTTPHeaders = ["Content-Type": "application/json",
                                   "Authorization": "Bearer \(UserManager.shared.getAccessToken)"]
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
                                                     [ListEntity].self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
            
        }
    }
    
    func getArchivingDetailAPI(qnaId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.qnaURL + "/\(qnaId)"
        let header: HTTPHeaders = ["Content-Type": "application/json",
                                   "Authorization": "Bearer \(UserManager.shared.getAccessToken)"]
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
                                                     DetailEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
            
        }
    }
}
