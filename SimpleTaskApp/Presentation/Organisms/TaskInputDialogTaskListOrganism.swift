//
//  TaskInputDialogTaskListOrganism.swift
//  SimpleTaskApp
//
//  Created by ruiwatanabe on 2024/09/01.
//

import SwiftUI

// タスク入力ダイアログ全体を担当するView
struct TaskInputDialogTaskListOrganism: View {
    @Binding var isPresented: Bool
    @Binding var title: String
    @Binding var description: String
    var onSave: () -> Void
    var dialogTitle: String
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 16) {
                Text(dialogTitle)
                    .font(.headline)
                    .padding(.top, 16)
                
                TaskInputFormMolecule(
                    title: $title,
                    description: $description,
                    onSave: {
                        onSave()
                        isPresented = false
                    },
                    onCancel: {
                        isPresented = false
                    }
                )
            }
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 10)
            .padding(.horizontal, 40)
        }
        .opacity(isPresented ? 1 : 0)
        .animation(.easeInOut, value: isPresented)
        .transition(.opacity)
        .zIndex(2)
    }
}

// プレビュー用コード
struct TaskInputDialog_Previews: PreviewProvider {
    @State static var isPresented = true
    @State static var title = "Sample Task"
    @State static var description = "Sample Description"
    
    static var previews: some View {
        TaskInputDialogTaskListOrganism(
            isPresented: $isPresented,
            title: $title,
            description: $description,
            onSave: {},
            dialogTitle: "New Task"
        )
    }
}
