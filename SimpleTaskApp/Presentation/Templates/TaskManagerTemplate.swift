import SwiftUI

// タスク管理のテンプレートコンポーネント
struct TaskManagerTemplate: View {
    @ObservedObject var viewModel: TaskViewModel
    @State private var isDialogPresented: Bool = false
    @State private var isEditing: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                TaskListOrganism(
                    tasks: viewModel.tasks,
                    onEdit: { task in
                        viewModel.selectedTask = task
                        viewModel.newTaskTitle = task.title
                        viewModel.newTaskDescription = task.description
                        isEditing = true
                        isDialogPresented = true
                    },
                    onDelete: viewModel.deleteTask
                )

                Button(action: {
                    viewModel.newTaskTitle = ""
                    viewModel.newTaskDescription = ""
                    isEditing = false
                    isDialogPresented = true
                }) {
                    Text("Add New Task")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Task Manager")
                        .font(.headline)
                }
            }
            .toolbarBackground(Color(uiColor: .secondarySystemBackground), for: .navigationBar)

            if isDialogPresented {
                TaskInputDialogTaskListOrganism(
                    isPresented: $isDialogPresented,
                    title: $viewModel.newTaskTitle,
                    description: $viewModel.newTaskDescription,
                    onSave: {
                        if isEditing {
                            viewModel.editTask()
                        } else {
                            viewModel.addTask()
                        }
                    },
                    dialogTitle: isEditing ? "Edit Task" : "New Task"
                )
            }
        }
    }
}

// プレビュー用コード
struct TaskManagerTemplate_Previews: PreviewProvider {
    static var previews: some View {
        TaskManagerTemplate(viewModel: TaskViewModel(taskRepository: LocalTaskDataSource()))
    }
}
