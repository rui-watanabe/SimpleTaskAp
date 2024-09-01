//
//  TaskRepositoryTests.swift
//  SimpleTaskAppTests
//
//  Created by ruiwatanabe on 2024/09/01.
//

import XCTest
@testable import SimpleTaskApp

class TaskRepositoryTests: XCTestCase {
    
    var repository: TaskRepository!
    
    override func setUpWithError() throws {
        UserDefaults.resetDefaults()
        repository = LocalTaskDataSource()
    }
    
    override func tearDownWithError() throws {
        repository = nil
    }
    
    func testAddTask() {
        let task = Task(id: UUID(), title: "New Task", description: "Description")
        repository.addTask(task)
        
        let tasks = repository.fetchTasks()
        XCTAssertTrue(tasks.contains(where: { $0.id == task.id }))
    }
    
    func testDeleteTask() {
        let task = Task(id: UUID(), title: "Task to Delete", description: "Description")
        repository.addTask(task)
        repository.deleteTask(task)
        
        let tasks = repository.fetchTasks()
        XCTAssertFalse(tasks.contains(where: { $0.id == task.id }))
    }
    
    func testUpdateTask() {
        let task = Task(id: UUID(), title: "Task", description: "Description")
        repository.addTask(task)
        
        var updatedTask = task
        updatedTask.title = "Updated Task"
        repository.updateTask(updatedTask)
        
        let tasks = repository.fetchTasks()
        XCTAssertTrue(tasks.contains(where: { $0.title == "Updated Task" }))
    }
    
    func testFetchTasks() {
        let task1 = Task(id: UUID(), title: "Task 1", description: "Description 1")
        let task2 = Task(id: UUID(), title: "Task 2", description: "Description 2")
        
        repository.addTask(task1)
        repository.addTask(task2)
        
        let tasks = repository.fetchTasks()
        XCTAssertEqual(tasks.count, 2)
    }
}
