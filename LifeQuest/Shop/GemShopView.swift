//
//  GemShopView.swift
//  LifeQuest
//
//  Created by Mac on 2026/3/4.
//

import SwiftUI

struct GemShopView: View {
    @ObservedObject var viewModel: GameViewModel
    @Binding var showingAlert: Bool
    @Binding var lastItem: ShopItem?
    @Binding var showInsufficientAlert: Bool
    
    let columns = [GridItem(.adaptive(minimum: 160, maximum: 180))]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.gemShopItems) { item in
                    ShopItemCard(item: item) {
                        if viewModel.purchase(item: item) {
                            lastItem = item
                            showingAlert = true
                        } else {
                            showInsufficientAlert = true
                        }
                    }
                }
            }
            .padding()
        }
    }
}
