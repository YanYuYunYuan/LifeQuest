//
//  SpecialOfferCard.swift
//  LifeQuest
//
//  Created by Mac on 2026/3/4.
//

import SwiftUI

struct SpecialOfferCard: View {
    let item: ShopItem
    let onPurchase: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: item.icon)
                    .font(.title)
                    .foregroundColor(.purple)
                
                Spacer()
                
                // 折扣标签（示例）
                Text("限时")
                    .font(.caption2)
                    .bold()
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(4)
            }
            
            Text(item.name)
                .font(.headline)
            
            Text(item.description)
                .font(.caption)
                .foregroundColor(.secondary)
            
            HStack {
                Label("\(item.price)", systemImage: item.currency == .coins ? "dollarsign.circle" : "crown.fill")
                    .font(.subheadline)
                    .foregroundColor(item.currency == .coins ? .yellow : .blue)
                
                Spacer()
                
                Button(action: onPurchase) {
                    Text("抢购")
                        .font(.caption)
                        .bold()
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .frame(width: 180)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.purple.opacity(0.3), lineWidth: 1)
        )
    }
}
