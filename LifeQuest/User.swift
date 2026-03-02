//
//  User.swift
//  LifeQuest
//
//  Created by Mac on 2026/3/1.
//

import Foundation
// MARK: - 用户模型
struct User {
    var level: Int = 1
    var exp: Int = 0
    var expToNextLevel: Int = 100
    var coins: Int = 150
    var gems: Int = 2
    var hearts: Int = 3          // 当前生命值 (0-3)
    var maxHearts: Int = 3
    var nickname: String = "冒险者"
    var avatar: String = "person.circle.fill"
    var title: String = "初心者"
}
