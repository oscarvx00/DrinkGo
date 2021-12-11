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
            Manufacturer(name: "TEST 1", type: ManufacturerType.NATIONAL, beers: [Beer(name: "TEST 1", type: "LAGER"), Beer(name: "TEST 2", type: "BLACK")]),
            Manufacturer(name: "TEST 2", type: ManufacturerType.NATIONAL, beers: [Beer(name: "TEST 3", type: "TEST")]),
            Manufacturer(name: "TEST 3", type: ManufacturerType.INTERNATIONAL, beers: [])
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
        let manufacturer = Manufacturer()
        manufacturers.append(manufacturer)
        return manufacturer.uuid
    }
    
    func deleteManufacturers(uuids: [UUID]) {
        abort()
    }

    func getManufacturer(uuid: UUID) -> Manufacturer {
        for m in manufacturers{
            if m.uuid == uuid{
                return m
            }
        }
        
        //TODO: CHECK ERROR
        return manufacturers[0]
    }

    func updateManufacturer(manufacturer: Manufacturer) {
        if let i = manufacturers.firstIndex(where: { $0.uuid == manufacturer.uuid}){
            manufacturers[i] = manufacturer
        }
    }

    func insertEmptyBeerToManufacturer(manufacturerUUID: UUID) -> Beer {
        abort()
    }

    func deleteBeers(beersUUID: [UUID], manufacturerUUID: UUID) {
        abort()
    }
    
    
}
