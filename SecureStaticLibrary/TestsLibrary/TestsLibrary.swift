//
//  TestsLibrary.swift
//  TestsLibrary
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import XCTest
@testable import SecureStaticLibrary

class TestsLibrary: XCTestCase {
    //--------------------------------------------------------------------
    //Variables
    let lo1 = LoginAttempt(id: 0, username: "ciberscanner@gmail.com", date: "2020-10-05", access: "true", country: "Colombia")
    let lo2 = LoginAttempt(id: 0, username: "ciberscanner@gmail.com", date: "2020-10-06", access: "false", country: "Colombia")
    let lo3 = LoginAttempt(id: 0, username: "ciberscanner@gmail.com", date: "2020-10-07", access: "true", country: "Colombia")
    let lo4 = LoginAttempt(id: 0, username: "nikole@gmail.com", date: "2020-10-05", access: "true", country: "Colombia")
    let lo5 = LoginAttempt(id: 0, username: "nikole@gmail.com", date: "2020-10-05", access: "true", country: "Colombia")
    
    //MARK: -
    func testAddLogin(){
        let dbLogin = DBLogin(nameTable: "TestTableLogin")
        let message = dbLogin.insertLogin(user: lo1)
        XCTAssertEqual(message.code!, 1)
    }
    
    func testAddLoginWithBadUser(){
        let dbLogin = DBLogin(nameTable: "TestTableLogin")
        let message = dbLogin.insertLogin(user: lo5)
        XCTAssertEqual(message.code!, NotFound)
    }
    
    func testAddMultipleLogin(){
        let dbLogin = DBLogin(nameTable: "TestTableLogin")
        let count = dbLogin.readLogins().count
        _ = dbLogin.insertLogin(user: lo1)
        _ = dbLogin.insertLogin(user: lo2)
        _ = dbLogin.insertLogin(user: lo3)
        _ = dbLogin.insertLogin(user: lo4)
        _ = dbLogin.insertLogin(user: lo5)
        XCTAssertNotEqual(5, count)
    }
    
}
