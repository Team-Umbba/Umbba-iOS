//
//  AlbumImageEntity.swift
//  Umbba-iOS
//
//  Created by 고아라 on 3/11/24.
//

import Foundation

struct AlbumImageEntity: Codable {
    let fileName: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case fileName = "file_name"
        case url
    }
}
