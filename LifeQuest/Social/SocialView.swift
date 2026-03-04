//
//  SocialView.swift
//  LifeQuest
//
//  Created by Mac on 2026/2/28.
//

import SwiftUI


struct SocialView: View {
    @ObservedObject var gameViewModel: GameViewModel
    @State private var selectedTab = 0
    
    // 模拟数据（实际应由 ViewModel 提供）
    @State private var activities: [Activity] = []
    @State private var leaderboard: [LeaderboardEntry] = []
    @State private var challenges: [TeamChallenge] = []
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 顶部用户卡片（显示自己）
                HStack {
                    Image(systemName: gameViewModel.user.avatar)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.accentColor)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text(gameViewModel.user.nickname)
                            .font(.headline)
                        Text("Lv.\(gameViewModel.user.level) · \(gameViewModel.user.title)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    // 社交积分（示例）
                    Label("\(gameViewModel.user.coins)", systemImage: "coins")
                        .foregroundColor(.yellow)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                
                // 分段选择器
                Picker("社交", selection: $selectedTab) {
                    Text("好友动态").tag(0)
                    Text("排行榜").tag(1)
                    Text("组队挑战").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // 内容区域
                TabView(selection: $selectedTab) {
                    FriendsActivityView(activities: $activities)
                        .tag(0)
                    
                    LeaderboardView(entries: leaderboard, currentUserId: gameViewModel.user.nickname)
                        .tag(1)
                    
                    TeamChallengesView(challenges: $challenges)
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            .navigationTitle("冒险者公会")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: loadMockData)
        }
    }
    
    // 加载模拟数据
    private func loadMockData() {
        // 好友动态
        activities = [
            Activity(userName: "跑步侠", userAvatar: "hare", action: "完成了10公里跑步", timestamp: Date().addingTimeInterval(-3600), likes: 5),
            Activity(userName: "读书人", userAvatar: "book.fill", action: "读完《原子习惯》", timestamp: Date().addingTimeInterval(-7200), likes: 3),
            Activity(userName: "冥想者", userAvatar: "brain.head.profile", action: "连续冥想30天", timestamp: Date().addingTimeInterval(-86400), likes: 12)
        ]
        
        // 排行榜
        leaderboard = [
            LeaderboardEntry(rank: 1, userName: "大神01", userAvatar: "crown.fill", level: 30, points: 15800),
            LeaderboardEntry(rank: 2, userName: "自律达人", userAvatar: "star.fill", level: 28, points: 14200),
            LeaderboardEntry(rank: 3, userName: "跑步侠", userAvatar: "hare", level: 25, points: 13100),
            LeaderboardEntry(rank: 4, userName: "读书人", userAvatar: "book.fill", level: 22, points: 11500),
            LeaderboardEntry(rank: 5, userName: gameViewModel.user.nickname, userAvatar: gameViewModel.user.avatar, level: gameViewModel.user.level, points: gameViewModel.user.exp)
        ]
        
        // 组队挑战
        challenges = [
            TeamChallenge(name: "万人跑团", description: "本月累计跑步100km", participants: ["跑步侠", "风行者", "追风少年"], currentProgress: 67, totalGoal: 100, deadline: Date().addingTimeInterval(86400 * 7), joined: false),
            TeamChallenge(name: "读书会", description: "每人读完2本书", participants: ["读书人", "书虫", "阅读者"], currentProgress: 3, totalGoal: 6, deadline: Date().addingTimeInterval(86400 * 3), joined: true)
        ]
    }
}
