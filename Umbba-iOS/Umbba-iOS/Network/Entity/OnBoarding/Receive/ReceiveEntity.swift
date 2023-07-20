//
//  ReceiveEntity.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/16.
//

struct ReceiveEntity: Codable {
    let userInfo: UserInfo2?
    let parentchildInfo: ParentchildInfo2?
    let pushTime: String?

    enum CodingKeys: String, CodingKey {
        case userInfo = "user_info"
        case parentchildInfo = "parentchild_info"
        case pushTime = "push_time"
    }
}

// MARK: - ParentchildInfo
struct ParentchildInfo2: Codable {
    let parentchildID: Int?
    let parentchildUsers: [UserInfo2]?
    let parentchildRelation: String?

    enum CodingKeys: String, CodingKey {
        case parentchildID = "parentchild_id"
        case parentchildUsers = "parentchild_users"
        case parentchildRelation = "parentchild_relation"
    }
}

// MARK: - UserInfo
struct UserInfo2: Codable {
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
