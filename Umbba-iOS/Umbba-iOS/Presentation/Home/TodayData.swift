//
//  TodayData.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/19.
//

class TodayData {
    static let shared = TodayData()
    
    var section: String
    var index: Int
    var topic: String
    var myQuestion: String
    
    init() {
        self.section = ""
        self.index = 0
        self.topic = ""
        self.myQuestion = ""
    }
}
