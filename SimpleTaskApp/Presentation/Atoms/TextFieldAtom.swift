//
//  TextFieldAtom.swift
//  SimpleTaskApp
//
//  Created by ruiwatanabe on 2024/09/01.
//

import SwiftUI

// シンプルなTextFieldコンポーネント
struct TextFieldAtom: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
    }
}

// プレビュー用コード
struct TextFieldAtom_Previews: PreviewProvider {
    @State static var sampleText = "Sample Text"
    
    static var previews: some View {
        TextFieldAtom(placeholder: "Enter text", text: $sampleText)
            .padding()
    }
}
