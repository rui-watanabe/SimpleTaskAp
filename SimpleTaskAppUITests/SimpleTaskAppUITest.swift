//
//  SimpleTaskAppUITest.swift
//  SimpleTaskAppUITests
//
//  Created by ruiwatanabe on 2024/09/01.
//

import XCTest

class SimpleTaskAppUITest: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        UserDefaults.resetDefaults()

        // テスト前の初期設定
        continueAfterFailure = false
        
        // アプリケーションのインスタンスを初期化して起動
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        // テスト後のクリーンアップ
        app = nil
    }
    
    func testAddingNewTask() throws {
        // "Add New Task"ボタンをタップして、新しいタスクの追加を開始
        app.buttons["Add New Task"].tap()
        
        // タスクタイトルと説明を入力
        let taskTitleTextField = app.textFields["Task Title"]
        taskTitleTextField.tap()
        taskTitleTextField.typeText("Test Task")
        
        let taskDescriptionTextField = app.textFields["Task Description"]
        taskDescriptionTextField.tap()
        taskDescriptionTextField.typeText("This is a test task description.")
        
        // "Save"ボタンをタップしてタスクを保存
        app.buttons["Save"].tap()
        
        // 新しいタスクがリストに表示されることを確認
        XCTAssertTrue(app.staticTexts["Test Task"].exists)
        XCTAssertTrue(app.staticTexts["This is a test task description."].exists)
    }
    
    func testEditingTask() throws {
        // 事前にタスクを追加
        app.buttons["Add New Task"].tap()
        
        let taskTitleTextField = app.textFields["Task Title"]
        taskTitleTextField.tap()
        taskTitleTextField.typeText("Task to Edit")
        
        let taskDescriptionTextField = app.textFields["Task Description"]
        taskDescriptionTextField.tap()
        taskDescriptionTextField.typeText("This task will be edited.")
        
        app.buttons["Save"].tap()
        
        // 編集ボタンをタップしてタスクを編集
        let editButton = app.buttons.matching(identifier: "pencil").firstMatch
        editButton.tap()
        
        let editTitleTextField = app.textFields["Task Title"]
        editTitleTextField.tap()
        editTitleTextField.clearText()
        editTitleTextField.typeText("Edited Task")
        
        let editDescriptionTextField = app.textFields["Task Description"]
        editDescriptionTextField.tap()
        editDescriptionTextField.clearText()
        editDescriptionTextField.typeText("Edited description.")
        
        app.buttons["Save"].tap()
        
        // タスクリストに編集されたタスクが表示されることを確認
        XCTAssertTrue(app.staticTexts["Edited Task"].exists)
        XCTAssertTrue(app.staticTexts["Edited description. description."].exists)
    }
    
    func testDeletingTask() throws {
        // 事前にタスクを追加
        app.buttons["Add New Task"].tap()
        
        let taskTitleTextField = app.textFields["Task Title"]
        taskTitleTextField.tap()
        taskTitleTextField.typeText("Task to Delete")
        
        let taskDescriptionTextField = app.textFields["Task Description"]
        taskDescriptionTextField.tap()
        taskDescriptionTextField.typeText("This task will be deleted.")
        
        app.buttons["Save"].tap()
        
        // タスクを削除
        let taskToDelete = app.staticTexts["Task to Delete"]
        taskToDelete.swipeLeft()
        app.buttons["Delete"].tap()
        
        // タスクが削除されたことを確認
        XCTAssertFalse(app.staticTexts["Task to Delete"].exists)
    }
}

// テキストフィールドの内容をクリアするための拡張機能
private extension XCUIElement {
    func clearText() {
        guard let stringValue = self.value as? String else { return }
        self.tap()
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        self.typeText(deleteString)
    }
}
