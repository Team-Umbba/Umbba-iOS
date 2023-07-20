//
//  InviteEntity.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/16.
//

struct InviteEntity: Codable {
    let parentchildID: Int?
    let userInfo: UserInfo?
    let parentchildRelation, pushTime, inviteCode: String?

    enum CodingKeys: String, CodingKey {
        case parentchildID = "parentchild_id"
        case userInfo = "user_info"
        case parentchildRelation = "parentchild_relation"
        case pushTime = "push_time"
        case inviteCode = "invite_code"
    }
}

// MARK: - UserInfo
struct UserInfo: Codable {
    let userID: Int?
    let name, gender: String?
    let bornYear: Int?
    let meChild: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name, gender
        case bornYear = "born_year"
        case meChild = "is_me_child"
    }
}
