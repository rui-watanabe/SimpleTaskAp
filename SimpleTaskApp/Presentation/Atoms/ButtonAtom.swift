//
//  ButtonAtom.swift
//  SimpleTaskApp
//
//  Created by ruiwatanabe on 2024/09/01.
//

import SwiftUI

// シンプルなボタンコンポーネント
struct ButtonAtom: View {
    var title: String
    var action: () -> Void
    var color: Color = .blue
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(color)
                .cornerRadius(10)
        }
    }
}

// プレビュー用コード
struct ButtonAtom_Previews: PreviewProvider {
    static var previews: some View {
        ButtonAtom(title: "Save", action: {})
            .padding()
    }
}
