//
//  User.swift
//  SecureStaticLibrary
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import Foundation

public class User: Codable {
    //--------------------------------------------------------------------
    //Variables
    public var id = 0
    public let username: String
    public let password: String
    //--------------------------------------------------------------------
    //Constructor
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    //--------------------------------------------------------------------
    //Constructor
    public init(id: Int, username: String, password: String) {
        self.id = id
        self.username = username
        self.password = password
    }
}
