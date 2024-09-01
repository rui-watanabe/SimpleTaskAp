//
//  GetTasksUseCase.swift
//  SimpleTaskApp
//
//  Created by ruiwatanabe on 2024/09/01.
//

import Foundation

// 全てのタスクを取得するUseCase
struct GetTasksUseCase {
    private let repository: TaskRepository
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    func execute() -> [Task] {
        return repository.fetchTasks()
    }
}
