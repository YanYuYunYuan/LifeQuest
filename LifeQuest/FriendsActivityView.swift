//
//  FriendsActivityView.swift
//  LifeQuest
//
//  Created by Mac on 2026/3/4.
//

import SwiftUI

struct FriendsActivityView: View {
    @Binding var activities: [Activity]
    
    var body: some View {
        List {
            ForEach(activities) { activity in
                ActivityRow(activity: activity) { updatedActivity in
                    if let index = activities.firstIndex(where: { $0.id == updatedActivity.id }) {
                        activities[index].isLiked = updatedActivity.isLiked
                        // 可以在此处更新 likes 计数（模拟网络请求）
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct ActivityRow: View {
    let activity: Activity
    let onLike: (Activity) -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: activity.userAvatar)
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.accentColor)
                .background(Color(.secondarySystemBackground))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(activity.userName)
                        .font(.headline)
                    Spacer()
                    Text(timeAgo(activity.timestamp))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Text(activity.action)
                    .font(.body)
                
                HStack {
                    Button(action: { toggleLike() }) {
                        HStack(spacing: 4) {
                            Image(systemName: activity.isLiked ? "heart.fill" : "heart")
                                .foregroundColor(activity.isLiked ? .red : .gray)
                            Text("\(activity.likes)")
                                .font(.caption)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    
                    Button("评论") {
                        // 评论功能预留
                    }
                    .font(.caption)
                    .foregroundColor(.blue)
                }
                .padding(.top, 4)
            }
        }
        .padding(.vertical, 8)
    }
    
    private func toggleLike() {
        var updated = activity
        updated.isLiked.toggle()
        // 用完整赋值代替 +=
        updated.likes = updated.likes + (updated.isLiked ? 1 : -1)
        onLike(updated)
    }
    
    private func timeAgo(_ date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}
