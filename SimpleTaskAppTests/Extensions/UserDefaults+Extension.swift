//
//  UserDefaults+Extension.swift
//  SimpleTaskAppTests
//
//  Created by ruiwatanabe on 2024/09/01.
//
import XCTest
@testable import SimpleTaskApp

extension UserDefaults {
    static func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        defaults.synchronize()
    }
}
