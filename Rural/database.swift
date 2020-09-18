//
//  database.swift
//  Rural
//
//  Created by Ivan Naranjo on 5/27/20.
//  Copyright © 2020 Ivan Naranjo. All rights reserved.
//

import Foundation
import SQLite3

struct Citas {
    var hospital: String
    var nui: Int32
    
}

class CitasManager {
var database: OpaquePointer?

static let shared = CitasManager()
static let deletion = CitasManager()

private init() {
}

    func connect() {
    if database != nil {
        return
    }
    
    let databaseURL = try! FileManager.default.url(
        for: .documentDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: false
    ).appendingPathComponent("Citas.sqlite")
    
    if sqlite3_open(databaseURL.path, &database) != SQLITE_OK {
        print("Error opening database")
        return
    }
    
    if sqlite3_exec(
        database,
        """
        CREATE TABLE IF NOT EXISTS citas (
            hospital TEXT
        )
        """,
        nil,
        nil,
        nil
    ) != SQLITE_OK {
        print("Error creating table: \(String(cString: sqlite3_errmsg(database)!))")
    }
}
    
    func create(hospital: String) -> Int {
        connect()
        
        var statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(
            database,
            "INSERT INTO citas (hospital) VALUES (\"\(hospital)\")",
            -1,
            &statement,
            nil
        ) == SQLITE_OK {
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error inserting note")
            }
        }
        else {
            print("Error creating cita insert statement")
        }
        
        sqlite3_finalize(statement)
        return Int(sqlite3_last_insert_rowid(database))
    }
    
    func getCitas() -> [Citas] {
        connect()
        
        var result: [Citas] = []
        var statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(database, "SELECT rowid, hospital FROM citas", -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                result.append(Citas(hospital: String(cString: sqlite3_column_text(statement, 1)), nui: sqlite3_column_int(statement, 0)))
            }
        }
        
        sqlite3_finalize(statement)
        return result
    }
    
    func saveNote(cita: Citas) {
        connect()
        
        var statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(
            database,
            "UPDATE citas SET hospital = ? WHERE rowid = ?",
            -1,
            &statement,
            nil
        ) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, NSString(string: cita.hospital).utf8String, -1, nil)
            sqlite3_bind_int(statement, 2, cita.nui)
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error saving cita")
            }
        }
        else {
            print("Error creating note update statement")
        }
        
        sqlite3_finalize(statement)
    }
    
    func deleteCita(cita: Citas) {
        connect()
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(database, "DELETE FROM citas WHERE rowid = ?;", -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, cita.nui)
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error deleting note")
            }
            
        }
        else {
            print("Error creating delete statement")
        }
        
        sqlite3_finalize(statement)
        
        
    }

    
}

