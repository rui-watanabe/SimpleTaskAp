//
//  DeleteTaskUseCase.swift
//  SimpleTaskApp
//
//  Created by ruiwatanabe on 2024/09/01.
//

import Foundation

// タスクを削除するUseCase
struct DeleteTaskUseCase {
    private let repository: TaskRepository
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    func execute(task: Task) {
        repository.deleteTask(task)
    }
}
