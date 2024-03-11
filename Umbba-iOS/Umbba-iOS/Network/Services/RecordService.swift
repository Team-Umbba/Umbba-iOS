//
//  RecordService.swift
//  Umbba-iOS
//
//  Created by 고아라 on 3/8/24.
//

import Foundation

import Alamofire

final class RecordService: BaseService {
    
    static let shared = RecordService()
    
    private override init() {}
}

extension RecordService {
    
    func getAlbumAPI(completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.albumURL
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
                                                     [AlbumEntity].self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
            
        }
    }
    
    func deleteAlbumAPI(albumId: Int,
                     completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.albumDeleteURL + "\(albumId)"
        let header: HTTPHeaders = NetworkConstant.hasTokenHeader
        let dataRequest = AF.request(url,
                                     method: .delete,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode,
                                                     data,
                                                     AlbumDeleteEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
            
        }
    }
}
