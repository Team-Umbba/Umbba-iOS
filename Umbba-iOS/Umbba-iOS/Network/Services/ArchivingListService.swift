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
    
    private func makeArchivingURL(sectionId: Int) -> String {
        let url = URLConstant.archivingURL + "/sectionId"
        return url
    }
    
    func getArchivingListAPI(completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = NetworkConstant.hasTokenHeader
        let dataRequest = AF.request(makeArchivingURL(sectionId: sectionId),
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
                                                     ListEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
            
        }
    }
}
