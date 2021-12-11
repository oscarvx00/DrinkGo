//
//  ManufacturerDetailViewModel.swift
//  ManufacturerDetailViewModel
//
//  Created by Oscar on 10/12/21.
//

import Foundation


class ManufacturerDetailViewModel {
    
    let manufacturerDetailDAO : ManufacturerDetailDAO = DatabaseManager.shared as ManufacturerDetailDAO
    
    var manufacturer : Manufacturer!
    
    func getManufacturer(uuid : UUID) -> ManufacturerDTO{
        self.manufacturer = manufacturerDetailDAO.getManufacturer(uuid: uuid)
        return ManufacturerDTO(manufacturer: self.manufacturer)
    }
    
    func updateManufacturer(name : String, type : ManufacturerType){
        manufacturer.name = name
        manufacturer.type = type
        manufacturerDetailDAO.updateManufacturer(manufacturer: manufacturer)
    }
    
}
