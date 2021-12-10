//
//  ManufacturerDetailDAO.swift
//  ManufacturerDetailDAO
//
//  Created by Oscar on 10/12/21.
//

import Foundation

protocol ManufacturerDetailDAO{
    
    func getManufacturer(uuid : UUID) -> Manufacturer
    func updateManufacturer(manufacturer : Manufacturer)
    func insertEmptyBeerToManufacturer(manufacturerUUID : UUID) -> Beer
    func deleteBeers(beersUUID : [UUID], manufacturerUUID : UUID)
    
}
