//
//  RecordService.swift
//  Umbba-iOS
//
//  Created by 고아라 on 3/8/24.
//

import Foundation

import Alamofire
import UIKit

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
    
    func patchAlbumImageAPI(completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.albumImageURL
        let header: HTTPHeaders = NetworkConstant.noTokenHeader
        let body: Parameters = [
            "img_prefix": "album/"
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
                                                     AlbumImageEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
            
        }
    }
    
    func putAlbumAPI(img: UIImage, serverUrl: String, completion: @escaping (Int) -> Void) {
        let imageData = img.jpegData(compressionQuality: 0.8) ?? Data()
        let dataRequest = AF.upload(imageData,
                                    to: serverUrl,
                                    method: .put,
                                    headers: ["Content-Type": "image/jpeg"])
        
        dataRequest.responseData { response in
            switch response.response?.statusCode {
            case 200:
                completion(200)
            default:
                break
            }
        }
    }
    
    func postAlbumAPI(title: String, content: String, fileName: String,
                      completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.albumURL
        let header: HTTPHeaders = NetworkConstant.hasTokenHeader
        let body: Parameters = [
            "title": title,
            "content": content,
            "img_file_name": fileName
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
                                                     AlbumDeleteEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
            
        }
    }
}
