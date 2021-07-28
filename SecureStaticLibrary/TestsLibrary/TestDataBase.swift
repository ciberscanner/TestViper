//
//  TestDataBase.swift
//  TestsLibrary
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import XCTest
@testable import SecureStaticLibrary

class TestDataBase: XCTestCase {
    //--------------------------------------------------------------------
    //Variables
    let u1 = User(username: "ciberscanner@gmail.com", password: "Abcd123*")
    let u2 = User(username: "nikole@gmail.com", password: "Abcd123*")
    
    //MARK: -
    func testAddUser(){
        let dbUser = DBUser(nameTable: "TestTable")
        let count = dbUser.readUsers().count
        let message = dbUser.addUser(user: u1)
        XCTAssertNotEqual(dbUser.readUsers().count, count, message.message!)
    }
    
    func testExistUser(){
        let dbUser = DBUser(nameTable: "TestTable")
        _ = dbUser.addUser(user: u1)
        let exist = dbUser.existUser(user: u1)
        XCTAssertTrue(exist)
    }
    
    func testAddSameUser() {
        let dbUser = DBUser(nameTable: "TestTable")
        let message = dbUser.addUser(user: u1)
        let message2 = dbUser.addUser(user: u1)
        XCTAssertNotEqual(message.code, message2.code, message.message!)
    }
    func testAddDiferentUser() {
        let dbUser = DBUser(nameTable: "TestTable")
        let message = dbUser.addUser(user: u1)
        let message2 = dbUser.addUser(user: u2)
        XCTAssertEqual(message.code, message2.code, message.message!)
    }
    
    func testLoginOKtUser() {
        let dbUser = DBUser(nameTable: "TestTable")
        _ = dbUser.addUser(user: u1)
        let login = dbUser.checkUser(user: u1)
        XCTAssertTrue(login)
    }
    
    func testLoginFailtUser() {
        let dbUser = DBUser(nameTable: "TestTable")
        _ = dbUser.addUser(user: u1)
        let login = dbUser.checkUser(user: u2)
        XCTAssertFalse(login)
    }
}
