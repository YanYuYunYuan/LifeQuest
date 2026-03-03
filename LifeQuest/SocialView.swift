//
//  SocialView.swift
//  LifeQuest
//
//  Created by Mac on 2026/2/28.
//

import SwiftUI

struct SocialView: View {
    @ObservedObject var viewModel: GameViewModel
    var body: some View {
        NavigationView {
                    Text("公会页面")
                        .navigationTitle("冒险者公会")
                }
    }
}

