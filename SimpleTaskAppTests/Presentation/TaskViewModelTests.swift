//
//  TaskViewModelTests.swift
//  SimpleTaskAppTests
//
//  Created by ruiwatanabe on 2024/09/01.
//

import XCTest
@testable import SimpleTaskApp

class TaskViewModelTests: XCTestCase {

    var viewModel: TaskViewModel!
    var repository: MockTaskRepository!
    
    override func setUpWithError() throws {
        UserDefaults.resetDefaults()
        repository = MockTaskRepository()
        viewModel = TaskViewModel(
            addTaskUseCase: AddTaskUseCase(repository: LocalTaskDataSource()),
            updateTaskUseCase: UpdateTaskUseCase(repository: LocalTaskDataSource()),
            deleteTaskUseCase: DeleteTaskUseCase(repository: LocalTaskDataSource()),
            getTasksUseCase: GetTasksUseCase(repository: LocalTaskDataSource())
        )
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        repository = nil
    }
    
    func testAddTask() {
        viewModel.newTaskTitle = "New Task"
        viewModel.newTaskDescription = "This is a new task."
        viewModel.addTask()
        
        XCTAssertEqual(viewModel.tasks.count, 1)
        XCTAssertEqual(viewModel.tasks.first?.title, "New Task")
    }

    func testEditTask() {
        let task = Task(id: UUID(), title: "Old Task", description: "Old Description")
        repository.addTask(task)
        viewModel.tasks = repository.fetchTasks()
        viewModel.selectedTask = task
        
        viewModel.newTaskTitle = "Updated Task"
        viewModel.newTaskDescription = "Updated Description"
        viewModel.editTask()
        
        XCTAssertEqual(viewModel.tasks.count, 1)
        XCTAssertEqual(viewModel.tasks.first?.title, "Updated Task")
        XCTAssertEqual(viewModel.tasks.first?.description, "Updated Description")
    }

    func testDeleteTask() {
        let task = Task(id: UUID(), title: "Task to Delete", description: "This task will be deleted.")
        repository.addTask(task)
        viewModel.tasks = repository.fetchTasks()
        
        viewModel.deleteTask(at: IndexSet(integer: 0))
        
        XCTAssertEqual(viewModel.tasks.count, 0)
    }
}
