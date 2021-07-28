//
//  DataApp.swift
//  SecureApp
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import Foundation
public class DataApp{
    //--------------------------------------------------------------------
    //Variables
    private let defaults: UserDefaults
    private let firsTime = "firstTime"
    //--------------------------------------------------------------------
    //
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    //--------------------------------------------------------------------
    //
    func firstTime() -> Bool {
        let rawValue = defaults.bool(forKey: firsTime)
        return rawValue
    }
    //--------------------------------------------------------------------
    //
    func saveFirstTime() {
        defaults.setValue(true, forKey: firsTime)
    }
}
