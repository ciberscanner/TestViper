//
//  LoginAttempt.swift
//  SecureStaticLibrary
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import Foundation

public class LoginAttempt: Codable {
    //--------------------------------------------------------------------
    //Variables
    public var id : Int = 0
    public let username: String
    public let date: String
    public let access: String
    public let country: String
    //--------------------------------------------------------------------
    //
    public init(id: Int, username: String, date: String, access: String, country: String) {
        self.id = id
        self.username = username
        self.date = date
        self.access = access
        self.country = country
    }
}
