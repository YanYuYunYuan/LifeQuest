//
//  HomeView.swift
//  LifeQuest
//
//  Created by Mac on 2026/2/28.
//

import SwiftUI
struct HomeView: View {
    @StateObject private var vm = GameViewModel()
    @State private var showingRecovery = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                // 顶部状态栏
                StatusBarView(user: vm.user)
                
                // 今日横幅
                BannerView()
                
                // 日常任务区域
                DailyQuestListView(
                    quests: vm.dailyQuests,
                    onComplete: { quest in
                        withAnimation(.spring()) {
                            vm.completeQuest(quest)
                        }
                    }
                )
                
                // 主线任务卡片
                MainQuestCardView(quest: vm.mainQuest)
                
                // 底部快捷按钮
                BottomActionView(
                    onRecover: { showingRecovery = true },
                    onReset: { vm.resetDailyQuests() }
                )
                .padding(.bottom, 20)
            }
            .padding(.horizontal)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .alert("恢复生命值", isPresented: $showingRecovery) {
            Button("花费50金币", action: { vm.recoverHeart() })
            Button("取消", role: .cancel) { }
        } message: {
            Text("恢复一颗心需要50金币。当前金币: \(vm.user.coins)")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
