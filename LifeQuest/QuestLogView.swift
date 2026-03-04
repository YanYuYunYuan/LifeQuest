//
//  QuestLogView.swift
//  LifeQuest
//
//  Created by Mac on 2026/2/28.
//

import SwiftUI
// Views/QuestLogView.swift
import SwiftUI

struct QuestLogView: View {
    @ObservedObject var viewModel: GameViewModel
    
    // 筛选类型：nil 表示全部
    @State private var selectedType: QuestType? = nil
    // 是否显示已完成任务（默认隐藏已完成）
    @State private var hideCompleted = true
    
    // 根据筛选条件过滤任务
    var filteredQuests: [Quest] {
        let typeFiltered = viewModel.quests(of: selectedType)
        if hideCompleted {
            return typeFiltered.filter { !$0.isCompleted }
        } else {
            return typeFiltered
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 筛选栏
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        FilterChip(title: "全部", isSelected: selectedType == nil) {
                            selectedType = nil
                        }
                        FilterChip(title: "日常", isSelected: selectedType == .daily) {
                            selectedType = .daily
                        }
                        FilterChip(title: "周常", isSelected: selectedType == .weekly) {
                            selectedType = .weekly
                        }
                        FilterChip(title: "主线", isSelected: selectedType == .main) {
                            selectedType = .main
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 8)
                
                // 隐藏已完成开关
                Toggle(isOn: $hideCompleted) {
                    Text("隐藏已完成")
                        .font(.subheadline)
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
                
                // 任务列表
                List {
                    ForEach(filteredQuests) { quest in
                        ZStack {
                            // 点击整行进入详情页
                            NavigationLink(destination: QuestDetailView(quest: quest, viewModel: viewModel)) {
                                EmptyView()
                            }
                            .opacity(0)
                            
                            // 自定义任务行
                            QuestLogRow(quest: quest) {
                                // 点击完成按钮时，调用 ViewModel 完成任务
                                _ = viewModel.completeQuest(byId: quest.id)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("任务日志")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
    }
}

// 筛选芯片组件
struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? Color.accentColor : Color(.tertiarySystemBackground))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(16)
        }
    }
}

// 任务日志行
struct QuestLogRow: View {
    let quest: Quest
    let onComplete: () -> Void
    
    var body: some View {
        HStack {
            // 图标
            Image(systemName: quest.icon)
                .font(.title2)
                .foregroundColor(typeColor(quest.type))
                .frame(width: 40)
            
            // 任务信息
            VStack(alignment: .leading, spacing: 4) {
                Text(quest.name)
                    .font(.headline)
                    .strikethrough(quest.isCompleted)
                
                HStack {
                    // 类型标签
                    Text(quest.type.rawValue)
                        .font(.caption2)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(typeColor(quest.type).opacity(0.2))
                        .foregroundColor(typeColor(quest.type))
                        .cornerRadius(4)
                    
                    // 奖励预览
                    Label("\(quest.coinReward)", systemImage: "coins")
                        .font(.caption2)
                        .foregroundColor(.yellow)
                    
                    if let progress = quest.progress {
                        Text("\(Int(progress * 100))%")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Spacer()
            
            // 完成按钮（如果未完成）
            if !quest.isCompleted {
                Button(action: onComplete) {
                    Image(systemName: "checkmark.circle")
                        .font(.title2)
                        .foregroundColor(.green)
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title2)
                    .foregroundColor(.green)
            }
        }
        .padding(.vertical, 4)
    }
    
    private func typeColor(_ type: QuestType) -> Color {
        switch type {
        case .daily: return .blue
        case .weekly: return .green
        case .main: return .purple
        }
    }
}

