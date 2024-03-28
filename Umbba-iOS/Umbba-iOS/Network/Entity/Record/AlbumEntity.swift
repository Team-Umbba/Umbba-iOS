//
//  AlbumEntity.swift
//  Umbba-iOS
//
//  Created by 고아라 on 3/8/24.
//

import Foundation

struct AlbumEntity: Codable {
    let albumID: Int
    let title, content, writer: String
    let imgURL: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case title, content, writer
        case imgURL = "img_url"
    }
}
