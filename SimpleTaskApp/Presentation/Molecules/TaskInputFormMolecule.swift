//
//  TaskInputFormMolecule.swift
//  SimpleTaskApp
//
//  Created by ruiwatanabe on 2024/09/01.
//

import SwiftUI

// タスク入力フォーム全体を担当するMolecule
struct TaskInputFormMolecule: View {
    @Binding var title: String
    @Binding var description: String
    var onSave: () -> Void
    var onCancel: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            TextFieldAtom(placeholder: "Task Title", text: $title)
            TextFieldAtom(placeholder: "Task Description", text: $description)
            
            HStack {
                ButtonAtom(title: "Cancel", action: onCancel, color: .red)
                ButtonAtom(title: "Save", action: onSave)
            }
        }
        .padding()
    }
}

// プレビュー用コード
struct TaskInputFormMolecule_Previews: PreviewProvider {
    @State static var sampleTitle = "Sample Task"
    @State static var sampleDescription = "Sample Description"
    
    static var previews: some View {
        TaskInputFormMolecule(
            title: $sampleTitle,
            description: $sampleDescription,
            onSave: {},
            onCancel: {}
        )
        .padding()
    }
}
