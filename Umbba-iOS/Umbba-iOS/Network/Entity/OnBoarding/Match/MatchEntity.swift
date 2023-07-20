//
//  MatchEntity.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/16.
//

import Foundation

struct MatchEntity: Codable {
    let parentchildID: Int?
    let isMatchFinish: Bool?
    let parentchildUsers: [ParentchildUser]?
    let parentchildRelation: String?

    enum CodingKeys: String, CodingKey {
        case parentchildID = "parentchild_id"
        case parentchildUsers = "parentchild_users"
        case parentchildRelation = "parentchild_relation"
        case isMatchFinish = "is_match_finish"
    }
}

// MARK: - ParentchildUser

struct ParentchildUser: Codable {
    let userID: Int?
    let name, gender: String?
    let bornYear: Int?
    let isMeChild: Bool?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name, gender
        case bornYear = "born_year"
        case isMeChild = "is_me_child"
    }
}
