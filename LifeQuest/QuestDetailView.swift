//
//  QuestDetailView.swift
//  LifeQuest
//
//  Created by Mac on 2026/3/2.
//

import SwiftUI

struct QuestDetailView: View {
    let quest: Quest
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 大图标
                Image(systemName: quest.icon)
                    .font(.system(size: 80))
                    .foregroundColor(.accentColor)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .clipShape(Circle())
                
                // 任务名称
                Text(quest.name)
                    .font(.largeTitle)
                    .bold()
                
                // 类型标签
                Text(quest.type.rawValue)
                    .font(.headline)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(typeColor(quest.type).opacity(0.2))
                    .foregroundColor(typeColor(quest.type))
                    .cornerRadius(8)
                
                // 描述
                Text(quest.description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Divider()
                
                // 奖励信息
                HStack(spacing: 30) {
                    VStack {
                        Image(systemName: "dollarsign.circle")
                            .font(.title)
                            .foregroundColor(.yellow)
                        Text("\(quest.coinReward)")
                            .font(.title2)
                            .bold()
                        Text("金币")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    VStack {
                        Image(systemName: "star.fill")
                            .font(.title)
                            .foregroundColor(.orange)
                        Text("\(quest.expReward)")
                            .font(.title2)
                            .bold()
                        Text("经验")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                // 进度信息
                if quest.type == .main {
                    if let progress = quest.progress {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("任务进度")
                                .font(.headline)
                            ProgressView(value: progress)
                                .progressViewStyle(LinearProgressViewStyle(tint: .purple))
                            Text("\(Int(progress * 100))%")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal)
                    }
                } else {
                    // 日常/周常任务显示连续天数
                    HStack {
                        Image(systemName: "flame.fill")
                            .foregroundColor(.orange)
                        Text("连续完成 \(quest.currentStreak) 天")
                            .font(.headline)
                    }
                }
                
                Spacer(minLength: 30)
                
                // 完成按钮
                if !quest.isCompleted {
                    Button(action: completeTask) {
                        Text("完成任务")
                            .font(.title2)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                } else {
                    Text("已完成")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .foregroundColor(.secondary)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
            }
            .padding()
        }
        .navigationTitle("任务详情")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func typeColor(_ type: QuestType) -> Color {
        switch type {
        case .daily: return .blue
        case .weekly: return .green
        case .main: return .purple
        }
    }
    
    private func completeTask() {
        _ = viewModel.completeQuest(byId: quest.id)
        dismiss()  // 返回上一页
    }
}
