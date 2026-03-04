//
//  LeaderboardView.swift
//  LifeQuest
//
//  Created by Mac on 2026/3/4.
//

import SwiftUI

struct LeaderboardView: View {
    let entries: [LeaderboardEntry]
    let currentUserId: String
    
    var body: some View {
        List(entries.sorted(by: { $0.rank < $1.rank })) { entry in
            HStack {
                Text("#\(entry.rank)")
                    .font(.headline)
                    .foregroundColor(rankColor(entry.rank))
                    .frame(width: 40)
                
                Image(systemName: entry.userAvatar)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.accentColor)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(entry.userName)
                        .font(.headline)
                        .foregroundColor(entry.userName == currentUserId ? .blue : .primary)
                    Text("Lv.\(entry.level)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text("\(entry.points) EXP")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.orange)
            }
            .padding(.vertical, 4)
        }
        .listStyle(PlainListStyle())
    }
    
    private func rankColor(_ rank: Int) -> Color {
        switch rank {
        case 1: return .yellow
        case 2: return .gray
        case 3: return .brown
        default: return .secondary
        }
    }
}
