//
//  ContentView.swift
//  LifeQuest
//
//  Created by Mac on 2026/2/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}
struct MainTabView: View {
    @State private var selectedTab = 0  // 默认选中首页
    @ObservedObject var viewModel: GameViewModel  // 接收
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(vm:viewModel )
                .tabItem {
                    Label("首页", systemImage: "house.fill")
                }
                .tag(0)
            
            QuestLogView(viewModel:viewModel )
                .tabItem {
                    Label("任务", systemImage: "checklist")
                }
                .tag(1)
            
            ProfileView(viewModel:viewModel )
                .tabItem {
                    Label("角色", systemImage: "person.fill")
                }
                .tag(2)
            
            ShopView(viewModel:viewModel )
                .tabItem {
                    Label("商店", systemImage: "cart.fill")
                }
                .tag(3)
            
            SocialView(gameViewModel:viewModel )
                .tabItem {
                    Label("公会", systemImage: "person.3.fill")
                }
                .tag(4)
        }
        .accentColor(.purple)  // 设置选中项的颜色
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
