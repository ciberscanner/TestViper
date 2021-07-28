//
//  DBMessage.swift
//  SecureStaticLibrary
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import Foundation

public let Success = 1
public let Exist = 2
public let Error = 3
public let NotFound = 4

public class DBMessage {
    //--------------------------------------------------------------------
    //Variables
    public var code: Int?
    public var message: String?
    //--------------------------------------------------------------------
    //Constructor
    init(code: Int) {
        self.code = code
        switch code {
        case Success:
            message = "The user was created successfully!"
        case Exist:
            message = "This user is already registered "
        case Error:
            message = "The user could not be saved "
        case NotFound:
            message = "The user could not be founded "
        default:
           message = "Error"
        }
    }
}
