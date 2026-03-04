//
//  ShopItem.swift
//  LifeQuest
//
//  Created by Mac on 2026/3/4.
//

import Foundation

// 货币类型
enum CurrencyType {
    case coins
    case gems
}

// 商品类型（用于购买后的特殊效果）
enum ItemType {
    case entertainment      // 普通娱乐消费，只扣除货币
    case recovery           // 恢复生命值
    case boost              // 双倍经验增益
    // 可根据需要扩展
}

struct ShopItem: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let icon: String         // SF Symbol 名称
    let price: Int
    let currency: CurrencyType
    let type: ItemType
}
