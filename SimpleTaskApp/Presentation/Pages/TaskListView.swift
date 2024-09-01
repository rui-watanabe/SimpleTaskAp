//
//  TaskListView.swift
//  SimpleTaskApp
//
//  Created by ruiwatanabe on 2024/09/01.
//

import SwiftUI

// ページ全体を表現するコンポーネント
struct TaskListView: View {
    @StateObject var viewModel = TaskViewModel(taskRepository: LocalTaskDataSource())
    
    var body: some View {
        NavigationView {
            TaskManagerTemplate(viewModel: viewModel)
        }
    }
}

// プレビュー用コード
struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

