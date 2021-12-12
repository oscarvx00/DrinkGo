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
    
    func addBeer() -> BeerTableDTO{
        return BeerTableDTO(beer: manufacturerDetailDAO.insertEmptyBeerToManufacturer(manufacturerUUID: manufacturer.uuid))
    }
    
    func deleteBeer(uuid : UUID){
        manufacturerDetailDAO.deleteBeer(beerUUID: uuid, manufacturerUUID: manufacturer.uuid)
    }
    
    func orderBeersBy(orderParam : BeerOrderParam) -> [BeerTableDTO]{
        
        let beerList = manufacturer.beerList
        var sortedList : [Beer]!
        
        switch orderParam {
        case .NAME:
            sortedList = beerList.sorted(by: {$0.name < $1.name})
        case .ALCOHOL:
            sortedList = beerList.sorted(by: {$0.alcoholGraduation < $1.alcoholGraduation})
        case .ENERGY:
            sortedList = beerList.sorted(by: {$0.energy < $1.energy})
        }
        
        return sortedList.map({return BeerTableDTO(beer: $0)})
        
    }
    
}
