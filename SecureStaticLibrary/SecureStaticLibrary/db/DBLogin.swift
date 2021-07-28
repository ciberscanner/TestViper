//
//  DBLogin.swift
//  SecureStaticLibrary
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import Foundation
import SQLite3

public class DBLogin{
    //--------------------------------------------------------------------
    //Variables
    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?
    var dbUser:DBUser?
    var nameTable = "login"
    //--------------------------------------------------------------------
    //Constructor
    public init(){
        db = openDatabase()
        createTable()
        dbUser = DBUser()
    }
    //--------------------------------------------------------------------
    //Constructor
    public init(nameTable: String){
        db = openDatabase()
        self.nameTable = nameTable
        deleteTable()
        createTable()
        dbUser = DBUser(nameTable: "TestTable")
        dbUser?.addUser(user: User(username: "ciberscanner@gmail.com", password: "Abcd123*"))
    }
    //--------------------------------------------------------------------
    //
    func openDatabase() -> OpaquePointer?{
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("error opening database")
            return nil
        }
        else{
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    //--------------------------------------------------------------------
    //Crate table
    func createTable() {
       let createTableString = "CREATE TABLE IF NOT EXISTS \(nameTable)(Id INTEGER PRIMARY KEY,username TEXT,date TEXT,access TEXT,country TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK{
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print("Login table created.")
            } else {
                print("Login table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    //--------------------------------------------------------------------
    //
    func deleteTable(){
        let deleteTableString = "DROP TABLE \(nameTable)"
        var deleteTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteTableString, -1, &deleteTableStatement, nil) == SQLITE_OK{
            if sqlite3_step(deleteTableStatement) == SQLITE_DONE{
                print("table delete.")
            } else {
                print("table could not be deleted.")
            }
        } else {
            print("Delete TABLE statement could not be prepared.")
        }
        sqlite3_finalize(deleteTableStatement)
    }
    //--------------------------------------------------------------------
    //Add Login
    public func insertLogin(user: LoginAttempt)->DBMessage{
        if !(dbUser?.existUser(user: User(username: user.username, password: "")))!{
            return DBMessage(code: NotFound)
        }
        let insertStatementString = "INSERT INTO \(nameTable) (Id, username, date, access, country) VALUES (?, ?, ?, ?,?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 2, (user.username as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (user.date as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (user.access as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (user.country as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row login.")
                sqlite3_finalize(insertStatement)
                return DBMessage(code: Success)
            } else {
                print("Could not insert row.")
                sqlite3_finalize(insertStatement)
                return DBMessage(code: Error)
            }
        } else {
            print("INSERT statement could not be prepared.")
            sqlite3_finalize(insertStatement)
            return DBMessage(code: Error)
        }
        
    }
    //--------------------------------------------------------------------
    //Load Logins
    public func readLogins() -> [LoginAttempt] {
        let queryStatementString = "SELECT * FROM \(nameTable);"
        var queryStatement: OpaquePointer? = nil
        var psns : [LoginAttempt] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let username = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let date = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let access = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let country = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                psns.append(LoginAttempt(id: Int(id), username: username, date: date, access: access, country: country))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
}
