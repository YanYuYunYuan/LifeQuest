//
//  ProfileView.swift
//  LifeQuest
//
//  Created by Mac on 2026/2/28.
//

// Views/ProfileView.swift
import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: GameViewModel
    
    // 成就网格布局
    let columns = [
        GridItem(.adaptive(minimum: 80, maximum: 100))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // 角色卡
                    VStack(spacing: 12) {
                        // 头像和昵称
                        HStack {
                            Image(systemName: viewModel.user.avatar)
                                .resizable()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.accentColor)
                                .background(Color(.secondarySystemBackground))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(viewModel.user.nickname)
                                    .font(.title2)
                                    .bold()
                                
                                Text(viewModel.user.title)
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
                                // 等级进度条
                                VStack(alignment: .leading, spacing: 2) {
                                    HStack {
                                        Text("Lv.\(viewModel.user.level)")
                                            .font(.caption)
                                            .bold()
                                        Spacer()
                                        Text("\(viewModel.user.exp)/\(viewModel.user.expToNextLevel) EXP")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                    }
                                    ProgressView(value: Double(viewModel.user.exp) / Double(viewModel.user.expToNextLevel))
                                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                                }
                                .padding(.top, 4)
                            }
                            .padding(.leading, 8)
                        }
                        
                        Divider()
                        
                        // 核心属性：金币、钻石、生命值
                        HStack(spacing: 30) {
                            Label("\(viewModel.user.coins)", systemImage: "dollarsign.circle")
                                .foregroundColor(.yellow)
                            Label("\(viewModel.user.gems)", systemImage: "crown.fill")
                                .foregroundColor(.blue)
                            HStack(spacing: 2) {
                                ForEach(0..<viewModel.user.maxHearts, id: \.self) { i in
                                    Image(systemName: i < viewModel.user.hearts ? "heart.fill" : "heart")
                                        .foregroundColor(i < viewModel.user.hearts ? .red : .gray)
                                }
                            }
                        }
                        .font(.headline)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                    
                    // 统计看板
                    VStack(alignment: .leading, spacing: 12) {
                        Text("统计")
                            .font(.title2)
                            .bold()
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            StatCard(title: "完成任务", value: "\(viewModel.totalCompletedQuests)", icon: "checkmark.circle.fill", color: .green)
                            StatCard(title: "最长连续", value: "\(viewModel.longestStreak)天", icon: "flame.fill", color: .orange)
                            StatCard(title: "本周金币", value: "\(viewModel.weeklyCoins)", icon: "dollarsign.circle", color: .yellow)
                        }
                    }
                    .padding(.horizontal)
                    
                    // 成就墙
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("成就")
                                .font(.title2)
                                .bold()
                            Spacer()
                            Text("\(achievementsUnlockedCount)/\(viewModel.achievements.count)")
                                .foregroundColor(.secondary)
                        }
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.achievements) { achievement in
                                AchievementGridItem(achievement: achievement)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // 下一级奖励预告
                    VStack(alignment: .leading, spacing: 8) {
                        Text("即将解锁")
                            .font(.title2)
                            .bold()
                        
                        NextLevelRewardView(
                            nextLevel: viewModel.user.level + 1,
                            rewardDescription: nextLevelReward(for: viewModel.user.level + 1)
                        )
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 30)
                }
                .padding(.vertical)
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .navigationTitle("角色状态")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // 计算已解锁成就数量
    var achievementsUnlockedCount: Int {
        viewModel.achievements.filter { $0.isUnlocked }.count
    }
    
    // 根据等级返回奖励描述（示例，可扩展）
    func nextLevelReward(for level: Int) -> String {
        switch level {
        case 2: return "新手大礼包"
        case 3: return "双倍经验卡"
        case 5: return "自定义任务权限"
        case 7: return "商店9折卡"
        case 10: return "周常任务助手"
        case 12: return "天赋系统"
        case 15: return "钻石津贴"
        case 18: return "幸运轮盘"
        case 21: return "任务委派功能"
        case 25: return "称号展示框"
        case 28: return "现实奖励兑换"
        case 30: return "传奇称号 & 重生系统"
        default: return "神秘奖励"
        }
    }
}
