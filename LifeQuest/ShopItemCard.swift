//
//  ShopItemCard.swift
//  LifeQuest
//
//  Created by Mac on 2026/3/4.
//

import SwiftUI

struct ShopItemCard: View {
    let item: ShopItem
    let onPurchase: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // 图标和价格
            HStack {
                Image(systemName: item.icon)
                    .font(.title2)
                    .foregroundColor(.accentColor)
                
                Spacer()
                
                // 价格标签
                HStack(spacing: 4) {
                    Image(systemName: item.currency == .coins ? "dollarsign.circle" : "crown.fill")
                        .font(.caption)
                        .foregroundColor(item.currency == .coins ? .yellow : .blue)
                    Text("\(item.price)")
                        .font(.caption)
                        .bold()
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color(.tertiarySystemBackground))
                .cornerRadius(8)
            }
            
            // 商品名称
            Text(item.name)
                .font(.headline)
                .lineLimit(1)
            
            // 描述
            Text(item.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(2)
                .frame(height: 32, alignment: .top)
            
            // 兑换按钮
            Button(action: onPurchase) {
                Text("兑换")
                    .font(.caption)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}
