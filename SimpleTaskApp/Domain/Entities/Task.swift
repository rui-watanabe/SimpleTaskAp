//
//  Task.swift
//  SimpleTaskApp
//
//  Created by ruiwatanabe on 2024/09/01.
//

import Foundation

// タスクのモデルを定義するエンティティ
struct Task: Identifiable, Codable {
    var id: UUID
    var title: String
    var description: String
}
