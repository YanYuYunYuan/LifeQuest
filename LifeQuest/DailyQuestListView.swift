//
//  DailyQuestListView.swift
//  LifeQuest
//
//  Created by Mac on 2026/3/1.
//

import SwiftUI
struct DailyQuestListView: View {
    let quests: [Quest]
    let onComplete: (Quest) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("今日日常")
                .font(.title2)
                .bold()
            
            ForEach(quests) { quest in
                DailyQuestRow(quest: quest, onComplete: onComplete)
            }
        }
    }
}
struct DailyQuestRow: View {
    let quest: Quest
    let onComplete: (Quest) -> Void
    
    var body: some View {
        HStack {
            // 图标
            Image(systemName: quest.icon)
                .font(.title2)
                .foregroundColor(.accentColor)
                .frame(width: 40)
            
            // 任务信息
            VStack(alignment: .leading, spacing: 4) {
                Text(quest.name)
                    .font(.headline)
                    .strikethrough(quest.isCompleted)
                HStack {
                    Image(systemName: "flame.fill")
                        .font(.caption2)
                        .foregroundColor(.orange)
                    Text("连续\(quest.currentStreak)天")
                        .font(.caption)
                    
                    Spacer()
                    
                    Label("\(quest.coinReward)", systemImage: "coins")
                        .font(.caption)
                        .foregroundColor(.yellow)
                }
            }
            
            Spacer()
            
            // 完成按钮
            Button(action: { onComplete(quest) }) {
                Image(systemName: quest.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundColor(quest.isCompleted ? .green : .gray)
            }
            .disabled(quest.isCompleted)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

//struct DailyQuestListView_Previews: PreviewProvider {
//    static var previews: some View {
//        DailyQuestListView()
//    }
//}
