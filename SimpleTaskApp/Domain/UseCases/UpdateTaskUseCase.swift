//
//  UpdateTaskUseCase.swift
//  SimpleTaskApp
//
//  Created by ruiwatanabe on 2024/09/01.
//

import Foundation

// タスクを更新するUseCase
struct UpdateTaskUseCase {
    private let repository: TaskRepository
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    func execute(task: Task) {
        repository.updateTask(task)
    }
}
