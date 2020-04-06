//
//  SettingManager.swift
//  RSSReader
//
//  Created by Dmitry Pasnenkov on 4/6/20.
//  Copyright © 2020 Dmitry Pasnenkov. All rights reserved.
//

import Foundation

enum SettingKeys: String {
    case updateTimerIntervalKey = "updateTimerInterval"
}

final class SettingManager {
    
    static var updateTimerInterval: Double {
        get {
            guard let value = getValue(by: .updateTimerIntervalKey) as? Double else { return 5.0 }
            return value
        }
        set {
            setValue(newValue, by: .updateTimerIntervalKey)
        }
    }
    
    private static func getValue (by key: SettingKeys) -> Any? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: key.rawValue)
    }
    
    private static func setValue (_ value: Any, by key: SettingKeys) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key.rawValue)
    }

}
