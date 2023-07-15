//
//  BaseService.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/16.
//

import Foundation

import Alamofire

class BaseService {
    func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ t: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<T>.self, from: data) else { return .pathErr }
        switch statusCode {
        case 200..<300: return .success(decodedData as Any)
        case 400..<500: return .requestErr(decodedData as Any)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
}
