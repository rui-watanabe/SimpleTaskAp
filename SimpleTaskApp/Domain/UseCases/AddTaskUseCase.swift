//
//  AddTaskUseCase.swift
//  SimpleTaskApp
//
//  Created by ruiwatanabe on 2024/09/01.
//

import Foundation

// 新しいタスクを追加するUseCase
struct AddTaskUseCase {
    private let repository: TaskRepository
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    func execute(title: String, description: String) {
        let newTask = Task(id: UUID(), title: title, description: description)
        repository.addTask(newTask)
    }
}

