//
//  QuestLogView.swift
//  LifeQuest
//
//  Created by Mac on 2026/2/28.
//

import SwiftUI

struct QuestLogView: View {
    var body: some View {
            NavigationView {
                Text("任务日志页面")
                    .navigationTitle("任务日志")
            }
        }
}

struct QuestLogView_Previews: PreviewProvider {
    static var previews: some View {
        QuestLogView()
    }
}
