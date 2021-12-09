//
//  ManufacturersDAO.swift
//  ManufacturersDAO
//
//  Created by Oscar on 9/12/21.
//

import Foundation


protocol ManufacturersDAO{

    func getManufacturers() -> [Manufacturer]
    func insertEmptyManufacturer() -> UUID
    func deleteManufacturers(uuids : [UUID])
    
}
