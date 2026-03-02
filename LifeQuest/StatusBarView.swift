//
//  StatusBarView.swift
//  LifeQuest
//
//  Created by Mac on 2026/3/1.
//

import SwiftUI

struct StatusBarView: View {
    let user: User
    
    var body: some View {
        HStack {
            // 头像和昵称
            HStack {
                Image(systemName: user.avatar)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.accentColor)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(user.nickname)
                        .font(.headline)
                    Text(user.title)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            // 等级和生命值
            HStack(spacing: 2) {
                // 等级
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("Lv.\(user.level)")
                        .font(.subheadline)
                        .bold()
                }
                
                // 生命值
                HStack(spacing: 2) {
                    ForEach(0..<user.maxHearts, id: \.self) { i in
                        Image(systemName: i < user.hearts ? "heart.fill" : "heart")
                            .foregroundColor(i < user.hearts ? .red : .gray)
                            .font(.system(size: 16))
                    }
                }
                
                // 钻石
                HStack(spacing: 2) {
                    Image(systemName: "crown.fill")
                        .foregroundColor(.blue)
                    Text("\(user.gems)")
                        .font(.subheadline)
                        .bold()
                }
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(20)
    }
}

//struct StatusBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatusBarView()
//    }
//}
