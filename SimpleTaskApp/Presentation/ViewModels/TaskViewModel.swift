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
    
    private let taskRepository: TaskRepository
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
        self.tasks = taskRepository.fetchTasks()
    }
    
    // 新しいタスクを追加する
    func addTask() {
        guard !newTaskTitle.isEmpty else { return }
        let newTask = Task(id: UUID(), title: newTaskTitle, description: newTaskDescription)
        taskRepository.addTask(newTask)
        tasks = taskRepository.fetchTasks()
    }
    
    // タスクを編集する
    func editTask() {
        guard let selectedTask = selectedTask else { return }
        var updatedTask = selectedTask
        updatedTask.title = newTaskTitle
        updatedTask.description = newTaskDescription
        taskRepository.updateTask(updatedTask)
        tasks = taskRepository.fetchTasks()
    }
    
    // タスクを削除する
    func deleteTask(at indexSet: IndexSet) {
        indexSet.forEach { taskRepository.deleteTask(tasks[$0]) }
        tasks = taskRepository.fetchTasks()
    }
}
