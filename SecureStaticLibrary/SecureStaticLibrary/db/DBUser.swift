//
//  DBUser.swift
//  SecureStaticLibrary
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import Foundation
import SQLite3

public class DBUser {
    //--------------------------------------------------------------------
    //Variables
    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?
    var nameTable = "user"
    
    //--------------------------------------------------------------------
    //Constructor
    public init(){
        db = openDatabase()
        createTableUser()
    }
    //--------------------------------------------------------------------
    //Constructor
    public init(nameTable: String){
        db = openDatabase()
        self.nameTable = nameTable
        deleteTable()
        createTableUser()
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
    //Create table
    func createTableUser() {
        let createTableString = "CREATE TABLE IF NOT EXISTS \(nameTable)(Id INTEGER PRIMARY KEY,username TEXT,password TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK{
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print("user table created.")
            } else {
                print("user table could not be created.")
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
    //Add User
    public func addUser(user: User)->DBMessage{
        if existUser(user:user){
            return DBMessage(code: Exist)
        }
        let insertStatementString = "INSERT INTO \(nameTable) (Id, username, password) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 2, (user.username as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (user.password as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
                sqlite3_finalize(insertStatement)
                return DBMessage(code: Success)
            } else {
                print("Could not insert row user.")
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
    //check if exist
    public func existUser(user:User) -> Bool {
        let users = readUsers()
        for u in users{
            if u.username.lowercased()  == user.username.lowercased(){
                return true
            }
        }
        return false
    }
    //--------------------------------------------------------------------
    //
    public func checkUser(user: User) -> Bool {
        let users = readUsers()
        for u in users{
            if u.username.lowercased()  == user.username.lowercased() && u.password == user.password{
                //print("Check username and password ")
                return true
            }
        }
        return false
    }
    //--------------------------------------------------------------------
    //Load Users
    public func readUsers() -> [User] {
        let queryStatementString = "SELECT * FROM \(nameTable);"
        var queryStatement: OpaquePointer? = nil
        var users : [User] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let username = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                users.append(User(id: Int(id), username: username, password: password))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return users
    }
    
}
