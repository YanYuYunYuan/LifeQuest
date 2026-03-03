//
//  LifeQuestApp.swift
//  LifeQuest
//
//  Created by Mac on 2026/2/28.
//

import SwiftUI

@main
struct LifeQuestApp: App {
    @StateObject private var gameViewModel = GameViewModel()
    var body: some Scene {
        WindowGroup {
            MainTabView(viewModel: gameViewModel)
        }
    }
}
