//
//  NextLevelRewardView.swift
//  LifeQuest
//
//  Created by Mac on 2026/3/3.
//

import SwiftUI

struct NextLevelRewardView: View {
    let nextLevel: Int
    let rewardDescription: String
    
    var body: some View {
        HStack {
            Image(systemName: "gift.fill")
                .foregroundColor(.purple)
            
            Text("Lv.\(nextLevel) 解锁: ")
                .font(.subheadline)
                .bold()
            + Text(rewardDescription)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

