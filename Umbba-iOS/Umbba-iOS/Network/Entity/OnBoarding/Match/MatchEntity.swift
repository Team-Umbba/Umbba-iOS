//
//  MatchEntity.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/16.
//

import Foundation

// MARK: - DataClass
struct MatchEntity: Codable {
    let parentchildID: Int
    let parentchildUsers: [ParentchildUser]
    let parentchildRelation: String

    enum CodingKeys: String, CodingKey {
        case parentchildID = "parentchild_id"
        case parentchildUsers = "parentchild_users"
        case parentchildRelation = "parentchild_relation"
    }
}

// MARK: - ParentchildUser
struct ParentchildUser: Codable {
    let userID: Int
    let name, gender: String
    let bornYear: Int
    let meChild, hasAlarm: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name, gender
        case bornYear = "born_year"
        case meChild = "me_child"
        case hasAlarm = "has_alarm"
    }
}
