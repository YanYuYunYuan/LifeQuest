//
//  ShopView.swift
//  LifeQuest
//
//  Created by Mac on 2026/2/28.
//

import SwiftUI

struct ShopView: View {
    @ObservedObject var viewModel: GameViewModel
    var body: some View {
        NavigationView {
                    Text("商店页面")
                        .navigationTitle("商店")
                }
    }
}

