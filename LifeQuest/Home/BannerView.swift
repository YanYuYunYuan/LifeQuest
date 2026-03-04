//
//  BannerView.swift
//  LifeQuest
//
//  Created by Mac on 2026/3/1.
//

import SwiftUI

struct BannerView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            LinearGradient(
                colors: [.blue, .purple],
                startPoint: .leading,
                endPoint: .trailing
            )
            .cornerRadius(16)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("早上好，冒险者！")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                Text("新的一天开始了，完成日常任务获取奖励吧！")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
            }
            .padding()
        }
        .frame(height: 100)
    }
}

struct BannerView_Previews: PreviewProvider {
    static var previews: some View {
        BannerView()
    }
}
