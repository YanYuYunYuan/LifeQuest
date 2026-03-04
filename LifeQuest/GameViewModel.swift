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
    @Published var weeklyQuests: [Quest] = [
         Quest(name: "整理房间", description: "整理房间", type: .weekly, coinReward: 30, expReward: 30, currentStreak: 0, icon: "house.fill"),
         Quest(name: "长跑一次", description: "长跑一次", type: .weekly, coinReward: 40, expReward: 40, currentStreak: 0, icon: "figure.walk"),
         Quest(name: "学习新技能", description: "学习2小时", type: .weekly, coinReward: 35, expReward: 35, currentStreak: 0, icon: "book.closed.fill")
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
    // 获取所有任务（用于日志页面）
    var allQuests: [Quest] {
        dailyQuests + weeklyQuests + [mainQuest]
    }
    
    // 根据类型筛选任务
    func quests(of type: QuestType?) -> [Quest] {
        guard let type = type else { return allQuests }
        switch type {
        case .daily: return dailyQuests
        case .weekly: return weeklyQuests
        case .main: return [mainQuest]
        }
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
            // 周常
            if let index = weeklyQuests.firstIndex(where: { $0.id == id }) {
                guard !weeklyQuests[index].isCompleted else { return false }
                weeklyQuests[index].isCompleted = true
                user.coins += weeklyQuests[index].coinReward
                user.exp += weeklyQuests[index].expReward
                weeklyQuests[index].currentStreak += 1
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

// ViewModels/GameViewModel.swift（扩展部分）
import SwiftUI

extension GameViewModel {
    // 金币商店商品
    var coinShopItems: [ShopItem] {
        [
            ShopItem(name: "看一集剧", description: "放松一下", icon: "tv", price: 30, currency: .coins, type: .entertainment),
            ShopItem(name: "喝奶茶", description: "奖励自己", icon: "cup.and.saucer.fill", price: 50, currency: .coins, type: .entertainment),
            ShopItem(name: "游戏1小时", description: "尽情娱乐", icon: "gamecontroller.fill", price: 40, currency: .coins, type: .entertainment),
            ShopItem(name: "生命药水", description: "恢复一颗心", icon: "heart.fill", price: 50, currency: .coins, type: .recovery),
            ShopItem(name: "双倍经验卡", description: "24小时双倍经验", icon: "bolt.fill", price: 60, currency: .coins, type: .boost)
        ]
    }
    
    // 钻石商店商品
    var gemShopItems: [ShopItem] {
        [
            ShopItem(name: "买衣服", description: "给自己添置新衣", icon: "tshirt.fill", price: 2, currency: .gems, type: .entertainment),
            ShopItem(name: "吃大餐", description: "美食奖励", icon: "fork.knife", price: 3, currency: .gems, type: .entertainment),
            ShopItem(name: "短途旅行", description: "周末放松", icon: "car.fill", price: 5, currency: .gems, type: .entertainment)
        ]
    }
    
    // 限时特惠商品（可动态更新，此处为示例）
    var specialOfferItems: [ShopItem] {
        [
            ShopItem(name: "双倍经验卡", description: "限时8折", icon: "bolt.circle", price: 48, currency: .coins, type: .boost),
            ShopItem(name: "生命礼包", description: "恢复两颗心", icon: "heart.circle.fill", price: 90, currency: .coins, type: .recovery)
        ]
    }
    
    // 购买商品
    func purchase(item: ShopItem) -> Bool {
        // 检查余额
        switch item.currency {
        case .coins:
            guard user.coins >= item.price else { return false }
            user.coins -= item.price
        case .gems:
            guard user.gems >= item.price else { return false }
            user.gems -= item.price
        }
        
        // 根据商品类型触发特殊效果
        switch item.type {
        case .recovery:
            if user.hearts < user.maxHearts {
                user.hearts += 1
            }
        case .boost:
            activateBoost()
        case .entertainment:
            // 纯娱乐，无需额外操作
            break
        }
        
        // 触感反馈
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        return true
    }
    
    private func activateBoost() {
        // 实际项目中可设置双倍经验过期时间，这里用 UserDefaults 简单存储
        let expiryDate = Date().addingTimeInterval(24 * 60 * 60) // 24小时
        UserDefaults.standard.set(expiryDate.timeIntervalSince1970, forKey: "boostExpiry")
    }
}
