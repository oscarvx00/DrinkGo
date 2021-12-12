//
//  DatabaseManager.swift
//  DatabaseManager
//
//  Created by Oscar on 9/12/21.
//

import Foundation

class DatabaseManager : DatabaseConfigProtocol, ManufacturersDAO, ManufacturerDetailDAO, BeerDetailDAO{

    
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
    
    func deleteManufacturer(uuid: UUID) {
        if let index = manufacturers.firstIndex(where: {$0.uuid == uuid}){
            manufacturers.remove(at: index)
        }
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
        let beer = Beer(name: "Name...", type: "Type...")
        if let index = manufacturers.firstIndex(where: {$0.uuid == manufacturerUUID}){
            manufacturers[index].beerList.append(beer)
        }
        return beer
    }

    func deleteBeer(beerUUID: UUID, manufacturerUUID: UUID) {
        if let parentIndex = manufacturers.firstIndex(where: {$0.uuid == manufacturerUUID}){
            if let beerIndex = manufacturers[parentIndex].beerList.firstIndex(where: {$0.uuid == beerUUID}){
                manufacturers[parentIndex].beerList.remove(at: beerIndex)
            }
        }
    }
    
    func getBeer(beerUUID: UUID, manufacturerUUID: UUID) -> Beer {
        if let parent = manufacturers.first(where: {$0.uuid == manufacturerUUID}){
            if let beer = parent.beerList.first(where: {$0.uuid == beerUUID}){
                return beer
            }
        }
        
        //ERROR CASE
        return manufacturers[0].beerList[0]
    }
    
    func updateBeer(beer: Beer, manufacturerUUID: UUID) {
        if let parentIndex = manufacturers.firstIndex(where: {$0.uuid == manufacturerUUID}){
            if let beerIndex = manufacturers[parentIndex].beerList.firstIndex(where: {$0.uuid == beer.uuid}){
                manufacturers[parentIndex].beerList[beerIndex] = beer
            }
        }
    }
    
    
    
}
