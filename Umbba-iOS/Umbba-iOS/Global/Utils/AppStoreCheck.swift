//
//  AppstoreCheck.swift
//  Umbba-iOS
//
//  Created by 최영린 on 10/3/23.
//

import Foundation

enum VersionError: Error {
    case invalidResponse, invalidAppIdInfo
}

class AppStoreCheck {
    static func isUpdateAvailable(completion: @escaping (Bool?, Error?) -> Void) throws -> URLSessionDataTask {
        guard let info = Bundle.main.infoDictionary,
            let currentVersion = info["CFBundleShortVersionString"] as? String,
            let url = URL(string: "http://itunes.apple.com/kr/lookup?id=6450973870") else {
                throw VersionError.invalidAppIdInfo
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let error = error { throw error }
                guard let data = data else { throw VersionError.invalidResponse }
                let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
                guard let result = (json?["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String else {
                    throw VersionError.invalidResponse
                }
                let verFloat = NSString.init(string: version).floatValue
                let currentVerFloat = NSString.init(string: currentVersion).floatValue
                completion(verFloat > currentVerFloat, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
        return task
    }
}
