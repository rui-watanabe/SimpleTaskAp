//
//  TaskViewModel.swift
//  SimpleTaskApp
//
//  Created by ruiwatanabe on 2024/09/01.
//

import Foundation
import SwiftUI

// タスクのビジネスロジックを管理するViewModel
class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var newTaskTitle: String = ""
    @Published var newTaskDescription: String = ""
    @Published var selectedTask: Task?

    
    private let addTaskUseCase: AddTaskUseCase
    private let updateTaskUseCase: UpdateTaskUseCase
    private let deleteTaskUseCase: DeleteTaskUseCase
    private let getTasksUseCase: GetTasksUseCase
    
    init(addTaskUseCase: AddTaskUseCase,
         updateTaskUseCase: UpdateTaskUseCase,
         deleteTaskUseCase: DeleteTaskUseCase,
         getTasksUseCase: GetTasksUseCase) {
        self.addTaskUseCase = addTaskUseCase
        self.updateTaskUseCase = updateTaskUseCase
        self.deleteTaskUseCase = deleteTaskUseCase
        self.getTasksUseCase = getTasksUseCase
        self.tasks = getTasksUseCase.execute()
    }
    
    // 新しいタスクを追加する
    func addTask() {
        guard !newTaskTitle.isEmpty else { return }
        addTaskUseCase.execute(title: newTaskTitle, description: newTaskDescription)
        tasks = getTasksUseCase.execute()
    }
    
    // タスクを編集する
    func editTask() {
        guard let selectedTask = selectedTask else { return }
        var newTask: Task = selectedTask
        newTask.title = newTaskTitle
        newTask.description = newTaskDescription
        updateTaskUseCase.execute(task: newTask)
        tasks = getTasksUseCase.execute()
    }
    
    // タスクを削除する
    func deleteTask(at indexSet: IndexSet) {
        indexSet.forEach { deleteTaskUseCase.execute(task: tasks[$0]) }
        tasks = getTasksUseCase.execute()
    }
}
