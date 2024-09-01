//
//  MockTaskRepository.swift
//  SimpleTaskAppTests
//
//  Created by ruiwatanabe on 2024/09/01.
//

import XCTest
@testable import SimpleTaskApp

// モックリポジトリ
class MockTaskRepository: TaskRepository {
    var tasks: [Task] = []
    
    func addTask(_ task: Task) {
        tasks.append(task)
    }
    
    func deleteTask(_ task: Task) {
        tasks.removeAll { $0.id == task.id }
    }
    
    func updateTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
        }
    }
    
    func fetchTasks() -> [Task] {
        return tasks
    }
}
