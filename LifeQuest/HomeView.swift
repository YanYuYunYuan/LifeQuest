import SwiftUI

struct HomeView: View {
    @StateObject private var vm = GameViewModel()
    @State private var showingRecovery = false
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    StatusBarView(user: vm.user)
                    BannerView()
                    
                    DailyQuestListView(
                        quests: vm.dailyQuests,
                        onComplete: { quest in
                            withAnimation(.spring()) {
                                vm.completeQuest(quest)
                            }
                        },
                        viewModel: vm
                    )
                    
                    MainQuestCardView(quest: vm.mainQuest, viewModel: vm)
                    
                    BottomActionView(
                        onRecover: { showingRecovery = true },
                        onReset: { vm.resetDailyQuests() }
                    )
                    .padding(.bottom, 20)
                }
                .padding(.horizontal)
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .navigationTitle("冒险首页")
            .navigationBarTitleDisplayMode(.inline)
            .alert("恢复生命值", isPresented: $showingRecovery) {
                Button("花费50金币", action: { vm.recoverHeart() })
                Button("取消", role: .cancel) { }
            } message: {
                Text("恢复一颗心需要50金币。当前金币: \(vm.user.coins)")
            }
        }
    }
}
