//
//  TaskUseCasesTests.swift
//  SimpleTaskAppTests
//
//  Created by ruiwatanabe on 2024/09/01.
//

import XCTest
@testable import SimpleTaskApp

class TaskUseCasesTests: XCTestCase {
    
    var repository: MockTaskRepository!
    var addTaskUseCase: AddTaskUseCase!
    var deleteTaskUseCase: DeleteTaskUseCase!
    var updateTaskUseCase: UpdateTaskUseCase!
    var getTasksUseCase: GetTasksUseCase!
    
    override func setUpWithError() throws {
        UserDefaults.resetDefaults()
        repository = MockTaskRepository()
        addTaskUseCase = AddTaskUseCase(repository: repository)
        deleteTaskUseCase = DeleteTaskUseCase(repository: repository)
        updateTaskUseCase = UpdateTaskUseCase(repository: repository)
        getTasksUseCase = GetTasksUseCase(repository: repository)
    }
    
    override func tearDownWithError() throws {
        repository = nil
        addTaskUseCase = nil
        deleteTaskUseCase = nil
        updateTaskUseCase = nil
        getTasksUseCase = nil
    }
    
    func testAddTask() {
        let task = Task(id: UUID(), title: "New Task", description: "Description")
        addTaskUseCase.execute(title: task.title, description: task.description)
        
        let tasks = getTasksUseCase.execute()
        XCTAssertTrue(tasks.contains(where: { $0.title == task.title }))
    }
    
    func testDeleteTask() {
        let task = Task(id: UUID(), title: "Task to Delete", description: "Description")
        addTaskUseCase.execute(title: task.title, description: task.description)
        let tasks = getTasksUseCase.execute()
        deleteTaskUseCase.execute(task: tasks[0])
        
        let newTasks = getTasksUseCase.execute()
        XCTAssertFalse(newTasks.contains(where: { $0.title == task.title }))
    }
    
    func testUpdateTask() {
        let task = Task(id: UUID(), title: "Task", description: "Description")
        addTaskUseCase.execute(title: task.title, description: task.description)
        
        var updatedTask = task
        updatedTask.title = "Updated Task"
        updatedTask.id = getTasksUseCase.execute()[0].id

        updateTaskUseCase.execute(task: updatedTask)
        
        let newTasks = getTasksUseCase.execute()

        XCTAssertTrue(newTasks.contains(where: { $0.title == "Updated Task" }))
    }
    
    func testGetTasks() {
        let task1 = Task(id: UUID(), title: "Task 1", description: "Description 1")
        let task2 = Task(id: UUID(), title: "Task 2", description: "Description 2")
        
        addTaskUseCase.execute(title: task1.title, description: task1.description)
        addTaskUseCase.execute(title: task2.title, description: task2.description)
        
        let tasks = getTasksUseCase.execute()
        XCTAssertEqual(tasks.count, 2)
    }
}
