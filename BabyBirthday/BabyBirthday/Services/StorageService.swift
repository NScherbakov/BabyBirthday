//
//  StorageService.swift
//  BabyBirthday
//
//  Created by Nikolay on 9/22/20.
//  Copyright © 2020 Nikolay. All rights reserved.
//

import Foundation

//private static var kName = "kName"

enum SettingsKey: String {
    case babyName
}

class StorageService {
    
    static func storageBaby(name: String) {
        UserDefaults.standard.set(name, forKey: SettingsKey.babyName.rawValue)
    }
    
    static func readBabyName() -> String? {
        return UserDefaults.standard.string(forKey: SettingsKey.babyName.rawValue)
    }
}
