//
//  SocialModels.swift
//  LifeQuest
//
//  Created by Mac on 2026/3/4.
//

import Foundation

// 好友动态条目
struct Activity: Identifiable {
    let id = UUID()
    let userName: String
    let userAvatar: String      // SF Symbol 名称
    let action: String           // 完成了什么任务
    let timestamp: Date
    var likes: Int
    var isLiked: Bool = false
}

// 排行榜条目
struct LeaderboardEntry: Identifiable {
    let id = UUID()
    let rank: Int
    let userName: String
    let userAvatar: String
    let level: Int
    let points: Int              // 总经验或金币
}

// 组队挑战
struct TeamChallenge: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    var participants: [String]   // 参与者昵称
    let currentProgress: Double
    let totalGoal: Double
    let deadline: Date
    var joined: Bool             // 当前用户是否已加入
}
