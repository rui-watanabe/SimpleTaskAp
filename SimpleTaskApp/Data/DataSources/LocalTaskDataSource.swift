//
//  LocalTaskDataSource.swift
//  SimpleTaskApp
//
//  Created by ruiwatanabe on 2024/09/01.
//

import Foundation

// UserDefaultsを使用してタスクをローカルに保存・取得・更新するデータソース
class LocalTaskDataSource: TaskRepository {
    private let userDefaultsKey = "tasks"
    
    // タスクを追加する
    func addTask(_ task: Task) {
        var tasks = fetchTasks()
        tasks.append(task)
        saveTasks(tasks)
    }
    
    // タスクを削除する
    func deleteTask(_ task: Task) {
        var tasks = fetchTasks()
        tasks.removeAll { $0.id == task.id }
        saveTasks(tasks)
    }
    
    // タスクを更新する
    func updateTask(_ task: Task) {
        var tasks = fetchTasks()
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
            saveTasks(tasks)
        }
    }
    
    // 全てのタスクを取得する
    func fetchTasks() -> [Task] {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let tasks = try? JSONDecoder().decode([Task].self, from: data) else {
            return []
        }
        return tasks
    }
    
    // タスクをUserDefaultsに保存する
    private func saveTasks(_ tasks: [Task]) {
        let data = try? JSONEncoder().encode(tasks)
        UserDefaults.standard.set(data, forKey: userDefaultsKey)
    }
}
