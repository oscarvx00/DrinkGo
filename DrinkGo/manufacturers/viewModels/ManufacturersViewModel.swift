//
//  ManufacturersViewModel.swift
//  ManufacturersViewModel
//
//  Created by Oscar on 9/12/21.
//

import Foundation

class ManufacturersViewModel{
    
    let manufacturersDAO : ManufacturersDAO = DatabaseManager.shared as ManufacturersDAO
    let databaseConfig : DatabaseConfigProtocol = DatabaseManager.shared as DatabaseConfigProtocol
    
    init(){
        databaseConfig.openDatabase()
    }
    
    func getManufacturers() -> [ManufacturerType : [ManufacturersTableDTO]] {
        
        let manufacturers = manufacturersDAO.getManufacturers()
        
        var map = [ManufacturerType : [ManufacturersTableDTO]]()
        map[ManufacturerType.NATIONAL] = []
        map[ManufacturerType.INTERNATIONAL] = []
        
        for manufacturer in manufacturers{
            map[manufacturer.type]?.append(ManufacturersTableDTO(manufacturer: manufacturer))
        }
        return map
    }
    
    func addManufacturer() -> UUID{
        return manufacturersDAO.insertEmptyManufacturer()
    }
    
    func deleteManufacturer(uuid : UUID){
        manufacturersDAO.deleteManufacturer(uuid: uuid)
    }
    
}
