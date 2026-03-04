//
//  AchievementGridItem.swift
//  LifeQuest
//
//  Created by Mac on 2026/3/3.
//

import SwiftUI

struct AchievementGridItem: View {
    let achievement: Achievement
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(achievement.isUnlocked ? Color.yellow.opacity(0.2) : Color.gray.opacity(0.1))
                    .frame(width: 60, height: 60)
                
                Image(systemName: achievement.icon)
                    .font(.title2)
                    .foregroundColor(achievement.isUnlocked ? .yellow : .gray)
            }
            
            Text(achievement.name)
                .font(.caption)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .foregroundColor(achievement.isUnlocked ? .primary : .secondary)
            
            if let progress = achievement.progress, !achievement.isUnlocked {
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .frame(width: 50)
            }
        }
        .frame(width: 80, height: 100)
    }
}
