//
//  DatabaseManager.swift
//  DatabaseManager
//
//  Created by Oscar on 9/12/21.
//

import Foundation

struct DatabaseManager : DatabaseConfigProtocol, ManufacturersDAO{
    
    func openDatabase() -> Bool {
        abort()
    }
    
    func closeDatabase() {
        abort()
    }
    
    func getManufacturers() -> [Manufacturer] {
        abort()
    }
    
    func insertEmptyManufacturer() -> UUID {
        abort()
    }
    
    func deleteManufacturers(uuids: [UUID]) {
        abort()
    }
    
    
    static var shared : DatabaseManager = {
        let instance = DatabaseManager()
        return instance
    }()
    
    private init() {}
    
}
