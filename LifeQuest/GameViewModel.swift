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
    
    // 完成任务
    func completeQuest(_ quest: Quest) {
        guard let index = dailyQuests.firstIndex(where: { $0.id == quest.id }),
              !dailyQuests[index].isCompleted else { return }
        
        // 标记完成
        dailyQuests[index].isCompleted = true
        
        // 增加金币和经验
        user.coins += quest.coinReward
        user.exp += quest.expReward
        
        // 检查升级
        checkLevelUp()
        
        // 触感反馈
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    // 检查升级
    private func checkLevelUp() {
        while user.exp >= user.expToNextLevel {
            user.level += 1
            user.exp -= user.expToNextLevel
            user.expToNextLevel = Int(Double(user.expToNextLevel) * 1.2)  // 经验递增
            
            // 升级奖励（这里简化，实际可弹出奖励选择）
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
