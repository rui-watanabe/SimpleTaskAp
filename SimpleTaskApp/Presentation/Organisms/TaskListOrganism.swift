//
//  TaskListOrganism.swift
//  SimpleTaskApp
//
//  Created by ruiwatanabe on 2024/09/01.
//

import SwiftUI

// タスクリストコンポーネント
struct TaskListOrganism: View {
    var tasks: [Task]
    var onEdit: (Task) -> Void
    var onDelete: (IndexSet) -> Void
    
    var body: some View {
        List {
            ForEach(tasks) { task in
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(task.title)
                            .font(.headline)
                        Text(task.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Button(action: { onEdit(task) }) {
                        Image(systemName: "pencil")
                            .foregroundColor(.blue)
                    }
                    .accessibilityIdentifier("pencil")
                }
                .padding(.vertical, 5)
            }
            .onDelete(perform: onDelete)
        }
    }
}

// プレビュー用コード
struct TaskListOrganism_Previews: PreviewProvider {
    static var sampleTasks = [
        Task(id: UUID(), title: "Sample Task 1", description: "This is a description."),
        Task(id: UUID(), title: "Sample Task 2", description: "This is another description.")
    ]
    
    static var previews: some View {
        TaskListOrganism(tasks: sampleTasks, onEdit: { _ in }, onDelete: { _ in })
    }
}
