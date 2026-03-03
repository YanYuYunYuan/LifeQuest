//
//  GameViewModel.swift
//  LifeQuest
//
//  Created by Mac on 2026/3/1.
//

import Foundation
import UIKit
import Combine

class GameViewModel: ObservableObject {
    @Published var user = User()
    @Published var dailyQuests: [Quest] = [
        Quest(name: "晨间冥想", description: "冥想10分钟", type: .daily,
              coinReward: 10, expReward: 10, icon: "brain.head.profile"),
        Quest(name: "跑步3公里", description: "户外或跑步机", type: .daily,
              coinReward: 15, expReward: 15, icon: "hare"),
        Quest(name: "阅读30分钟", description: "任何书籍", type: .daily,
              coinReward: 10, expReward: 10, icon: "book.fill"),
        Quest(name: "喝8杯水", description: "保持水分", type: .daily,
              coinReward: 5, expReward: 5, icon: "drop.fill")
    ]
    
    @Published var mainQuest: Quest = Quest(
        name: "减肥5kg", description: "当前进度: 2.5kg", type: .main,
        coinReward: 50, expReward: 100, icon: "scalemass.fill"
    )
    // 成就列表
    @Published var achievements: [Achievement] = [
            Achievement(name: "早起鸟儿", description: "连续7天在7点前起床", icon: "sunrise.fill", isUnlocked: true),
            Achievement(name: "读书破万卷", description: "累计阅读10本书", icon: "books.vertical.fill", isUnlocked: false, progress: 0.6),
            Achievement(name: "钢铁之躯", description: "累计运动100次", icon: "bicycle", isUnlocked: true),
            Achievement(name: "理性消费者", description: "连续2周未兑换娱乐奖励", icon: "cart.badge.minus", isUnlocked: false),
            Achievement(name: "幸运星", description: "连续3次抽到好运卡", icon: "star.circle.fill", isUnlocked: true),
            Achievement(name: "不死鸟", description: "10次在中断后次日恢复", icon: "flame.fill", isUnlocked: false, progress: 0.3)
        ]
        
        // 计算统计属性
        var totalCompletedQuests: Int {
            // 假设我们记录完成任务数，这里简单返回示例值
            return 127
        }
        
        var longestStreak: Int {
            // 最长连续天数
            return 21
        }
        
        var weeklyCoins: Int {
            // 本周获得金币
            return 350
        }
    // 完成任务（通过 ID）
        func completeQuest(byId id: UUID) -> Bool {
            // 先在日常任务中查找
            if let index = dailyQuests.firstIndex(where: { $0.id == id }) {
                guard !dailyQuests[index].isCompleted else { return false }
                dailyQuests[index].isCompleted = true
                user.coins += dailyQuests[index].coinReward
                user.exp += dailyQuests[index].expReward
                dailyQuests[index].currentStreak += 1   // 简化处理，实际可判断是否连续
                checkLevelUp()
                return true
            }
            // 再检查主线任务
            if mainQuest.id == id {
                guard !mainQuest.isCompleted else { return false }
                mainQuest.isCompleted = true
                user.coins += mainQuest.coinReward
                user.exp += mainQuest.expReward
                checkLevelUp()
                return true
            }
            return false
        }
        
        // 兼容原有的 completeQuest(_:) 方法
        func completeQuest(_ quest: Quest) {
            _ = completeQuest(byId: quest.id)
        }
        
        // 更新任务进度（用于主线）
        func updateQuestProgress(id: UUID, progress: Double) {
            if let index = dailyQuests.firstIndex(where: { $0.id == id }) {
                dailyQuests[index].progress = progress
            } else if mainQuest.id == id {
                mainQuest.progress = progress
            }
        }
        
        // 检查升级
        private func checkLevelUp() {
            while user.exp >= user.expToNextLevel {
                user.level += 1
                user.exp -= user.expToNextLevel
                user.expToNextLevel = Int(Double(user.expToNextLevel) * 1.2)  // 经验递增
                
                // 升级奖励（简化）
                user.coins += 50
                user.gems += 1
            }
        }
        
    
    // 每日重置（通常在凌晨调用）
    func resetDailyQuests() {
        for i in 0..<dailyQuests.count {
            dailyQuests[i].isCompleted = false
        }
        
        // 检查未完成处罚：扣除生命值
        let unfinishedCount = dailyQuests.filter { !$0.isCompleted }.count
        if unfinishedCount > 0 {
            user.hearts = max(0, user.hearts - 1)
            // 可增加通知提示
        }
    }
    
    // 恢复生命值（通过金币或连续完成）
    func recoverHeart() {
        guard user.hearts < user.maxHearts && user.coins >= 50 else { return }
        user.coins -= 50
        user.hearts += 1
    }
}
