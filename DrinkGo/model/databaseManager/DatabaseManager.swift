//
//  DatabaseManager.swift
//  DatabaseManager
//
//  Created by Oscar on 9/12/21.
//

import Foundation

class DatabaseManager : DatabaseConfigProtocol, ManufacturersDAO, ManufacturerDetailDAO{
    
    
    var manufacturers = [Manufacturer]()
    
    static var shared : DatabaseManager = {
        let instance = DatabaseManager()
        return instance
    }()
    
    func openDatabase() -> Bool {
        //TEST
        manufacturers = [
            Manufacturer(name: "TEST 1", type: ManufacturerType.NATIONAL),
            Manufacturer(name: "TEST 2", type: ManufacturerType.NATIONAL),
            Manufacturer(name: "TEST 3", type: ManufacturerType.INTERNATIONAL)
        ]
        
        return true
    }
    
    func closeDatabase() {
        abort()
    }
    
    func getManufacturers() -> [Manufacturer] {
        return self.manufacturers
    }
    
    func insertEmptyManufacturer() -> UUID {
        abort()
    }
    
    func deleteManufacturers(uuids: [UUID]) {
        abort()
    }

    func getManufacturer(uuid: UUID) -> Manufacturer {
        abort()
    }

    func updateManufacturer(manufacturer: Manufacturer) {
        abort()
    }

    func insertEmptyBeerToManufacturer(manufacturerUUID: UUID) -> Beer {
        abort()
    }

    func deleteBeers(beersUUID: [UUID], manufacturerUUID: UUID) {
        abort()
    }
    
    
}
