//
//  LandscapeManager.swift
//  MajuJayaLetsInteract
//
//  Created by Rajabul Haris on 29/04/21.
//

import Foundation

class LandscapeManager {
    static let shared = LandscapeManager()
    var isFirstLaunch: Bool {
        get {
            !UserDefaults.standard.bool(forKey: #function)
        } set {
            UserDefaults.standard.setValue(newValue, forKey: #function)
        }
    }
}
