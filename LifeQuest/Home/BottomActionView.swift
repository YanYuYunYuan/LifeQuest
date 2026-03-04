//
//  BottomActionView.swift
//  LifeQuest
//
//  Created by Mac on 2026/3/1.
//

import SwiftUI

struct BottomActionView: View {
    let onRecover: () -> Void
    let onReset: () -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: onRecover) {
                Label("恢复", systemImage: "heart.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            
            Button(action: onReset) {
                Label("重置", systemImage: "arrow.clockwise")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
//struct BottomActionView_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomActionView()
//    }
//}
