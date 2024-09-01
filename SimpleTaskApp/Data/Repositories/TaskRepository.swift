//
//  TaskRepository.swift
//  SimpleTaskApp
//
//  Created by ruiwatanabe on 2024/09/01.
//

import Foundation

// タスクデータの保存、取得、更新、削除を行うためのプロトコル
protocol TaskRepository {
    func addTask(_ task: Task)
    func deleteTask(_ task: Task)
    func updateTask(_ task: Task)
    func fetchTasks() -> [Task]
}
