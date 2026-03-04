//
//  ShopView.swift
//  LifeQuest
//
//  Created by Mac on 2026/2/28.
//

import SwiftUI

//struct ShopView: View {
//    @ObservedObject var viewModel: GameViewModel
//    var body: some View {
//        NavigationView {
//                    Text("商店页面")
//                        .navigationTitle("商店")
//                }
//    }
//}


struct ShopView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var selectedTab = 0
    @State private var showingPurchaseAlert = false
    @State private var lastPurchasedItem: ShopItem?
    @State private var showingInsufficientAlert = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 余额展示
                HStack {
                    Label("\(viewModel.user.coins)", systemImage: "dollarsign.circle")
                        .foregroundColor(.yellow)
                        .font(.title3)
                    
                    Spacer()
                    
                    Label("\(viewModel.user.gems)", systemImage: "crown.fill")
                        .foregroundColor(.blue)
                        .font(.title3)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                
                // 商店类型切换
                Picker("商店", selection: $selectedTab) {
                    Text("金币商店").tag(0)
                    Text("钻石商店").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // 商品列表（使用 TabView 支持滑动切换）
                TabView(selection: $selectedTab) {
                    CoinShopView(
                        viewModel: viewModel,
                        showingAlert: $showingPurchaseAlert,
                        lastItem: $lastPurchasedItem,
                        showInsufficientAlert: $showingInsufficientAlert
                    )
                    .tag(0)
                    
                    GemShopView(
                        viewModel: viewModel,
                        showingAlert: $showingPurchaseAlert,
                        lastItem: $lastPurchasedItem,
                        showInsufficientAlert: $showingInsufficientAlert
                    )
                    .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(minHeight: 300)
                
                // 限时特惠区
                VStack(alignment: .leading, spacing: 12) {
                    Text("限时特惠")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.specialOfferItems) { item in
                                SpecialOfferCard(item: item) {
                                    purchase(item)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
                
                Spacer(minLength: 0)
            }
            .navigationTitle("商店")
            .navigationBarTitleDisplayMode(.inline)
            .alert("兑换成功", isPresented: $showingPurchaseAlert) {
                Button("好的", role: .cancel) { }
            } message: {
                if let item = lastPurchasedItem {
                    Text("你已成功兑换 \(item.name)")
                }
            }
            .alert("余额不足", isPresented: $showingInsufficientAlert) {
                Button("好的", role: .cancel) { }
            } message: {
                Text("你的货币不足以购买此物品")
            }
        }
    }
    
    // 购买统一处理
    private func purchase(_ item: ShopItem) {
        if viewModel.purchase(item: item) {
            lastPurchasedItem = item
            showingPurchaseAlert = true
        } else {
            showingInsufficientAlert = true
        }
    }
}
