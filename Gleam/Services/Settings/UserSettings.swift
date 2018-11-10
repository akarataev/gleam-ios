//
//  UserSettings.swift
//  Gleam
//
//  Created by albert on 10/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation

struct UserSettings {
    
    struct UserSettingKeys {
        static let skipOnboarding = "skipOnboarding"
        static let lat = "lat"
        static let lon = "lon"
    }
    
    static var skipOnboarding: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserSettingKeys.skipOnboarding)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserSettingKeys.skipOnboarding)
        }
    }
    
    static var lat: Double {
        get {
            return UserDefaults.standard.double(forKey: UserSettingKeys.lat)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserSettingKeys.lat)
        }
    }
    
    static var lon: Double {
        get {
            return UserDefaults.standard.double(forKey: UserSettingKeys.lon)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserSettingKeys.lon)
        }
    }
}
