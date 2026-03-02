//
//  Quest.swift
//  LifeQuest
//
//  Created by Mac on 2026/3/1.
//

import Foundation

// MARK: - 任务类型
enum QuestType: String {
    case daily = "日常"
    case weekly = "周常"
    case main = "主线"
}

// MARK: - 任务模型
struct Quest: Identifiable {
    let id = UUID()
    var name: String
    var description: String
    var type: QuestType
    var coinReward: Int
    var expReward: Int
    var isCompleted: Bool = false
    var currentStreak: Int = 0
    var icon: String          // SF Symbol 名称
    var progress: Double? = nil   // 仅主线任务使用，0.0~1.0
}
