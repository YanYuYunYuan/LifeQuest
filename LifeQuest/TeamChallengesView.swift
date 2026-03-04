//
//  TeamChallengesView.swift
//  LifeQuest
//
//  Created by Mac on 2026/3/4.
//

import SwiftUI

struct TeamChallengesView: View {
    @Binding var challenges: [TeamChallenge]
    
    var body: some View {
        List {
            ForEach(challenges) { challenge in
                TeamChallengeCard(challenge: challenge) { updatedChallenge in
                    if let index = challenges.firstIndex(where: { $0.id == updatedChallenge.id }) {
                        challenges[index] = updatedChallenge
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct TeamChallengeCard: View {
    let challenge: TeamChallenge
    let onJoin: (TeamChallenge) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(challenge.name)
                    .font(.headline)
                Spacer()
                Text(deadlineText)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Text(challenge.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            // 参与者
            HStack(spacing: -8) {
                ForEach(challenge.participants.prefix(3), id: \.self) { name in
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.blue)
                        .background(Circle().fill(Color.white))
                        .overlay(
                            Text(String(name.prefix(1)))
                                .font(.caption)
                                .foregroundColor(.white)
                        )
                }
                if challenge.participants.count > 3 {
                    Text("+\(challenge.participants.count-3)")
                        .font(.caption)
                        .padding(.leading, 4)
                }
            }
            
            // 进度条
            VStack(alignment: .leading, spacing: 4) {
                ProgressView(value: challenge.currentProgress, total: challenge.totalGoal)
                    .progressViewStyle(LinearProgressViewStyle(tint: .green))
                Text("\(Int(challenge.currentProgress))/\(Int(challenge.totalGoal))")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            // 加入按钮
            if !challenge.joined {
                Button(action: { joinChallenge() }) {
                    Text("加入挑战")
                        .font(.caption)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            } else {
                Text("已加入")
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.green)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .padding(.vertical, 4)
    }
    
    private var deadlineText: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: challenge.deadline, relativeTo: Date())
    }
    
    private func joinChallenge() {
        var updated = challenge
        updated.joined = true
        updated.participants.append("我")
        onJoin(updated)
    }
}
