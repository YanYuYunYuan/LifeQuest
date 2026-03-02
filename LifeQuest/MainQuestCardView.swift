//
//  MainQuestCardView.swift
//  LifeQuest
//
//  Created by Mac on 2026/3/1.
//

import SwiftUI

struct MainQuestCardView: View {
    let quest: Quest
    @ObservedObject var viewModel: GameViewModel  // 用于传递给详情页
    
    var body: some View {
        NavigationLink(destination: QuestDetailView(quest: quest, viewModel: viewModel)) {
        VStack(alignment: .leading, spacing: 12) {
            Text("主线任务")
                .font(.title2)
                .bold()
            
            HStack {
                Image(systemName: quest.icon)
                    .font(.largeTitle)
                    .foregroundColor(.purple)
                
                VStack(alignment: .leading) {
                    Text(quest.name)
                        .font(.headline)
                    Text(quest.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // 奖励预览
                VStack(alignment: .trailing) {
                    Label("\(quest.coinReward)", systemImage: "coins")
                        .font(.caption)
                    Label("\(quest.expReward) EXP", systemImage: "star")
                        .font(.caption)
                }
            }
            
            // 进度条
            ProgressView(value: 0.5)
                .progressViewStyle(LinearProgressViewStyle(tint: .purple))
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}

//struct MainQuestCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainQuestCardView()
//    }
//}
