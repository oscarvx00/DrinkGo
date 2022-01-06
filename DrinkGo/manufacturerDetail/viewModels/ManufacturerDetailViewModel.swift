//
//  ManufacturerDetailViewModel.swift
//  ManufacturerDetailViewModel
//
//  Created by Oscar on 10/12/21.
//

import Foundation
import UIKit


class ManufacturerDetailViewModel {
    
    let manufacturerDetailDAO : ManufacturerDetailDAO = DatabaseManager.shared as ManufacturerDetailDAO
    
    var manufacturer : Manufacturer!
    
    func getManufacturer(uuid : UUID) -> ManufacturerDTO{
        self.manufacturer = manufacturerDetailDAO.getManufacturer(uuid: uuid)
        return ManufacturerDTO(manufacturer: self.manufacturer)
    }
    
    func updateManufacturer(name : String, type : ManufacturerType, image : UIImage?){
        manufacturer.name = name
        manufacturer.type = type
        if image != nil && ManufacturerDTO(manufacturer: manufacturer).logoImage != image{ //TEST IMAGE CHANGED
            manufacturer.logoImageName = manufacturerDetailDAO.saveImage(image: image!, oldImageName: manufacturer.logoImageName)
        }
        
        manufacturerDetailDAO.updateManufacturer(manufacturer: manufacturer)
    }
    
    func addBeer() -> BeerTableDTO{
        let beer  = manufacturerDetailDAO.insertEmptyBeerToManufacturer(manufacturerUUID: manufacturer.uuid)
        //manufacturer.beerList.append(beer)
        return BeerTableDTO(beer: beer)
    }
    
    func deleteBeer(uuid : UUID){
        if let beerIndex = manufacturer.beerList.firstIndex(where: {$0.uuid == uuid}){
            manufacturer.beerList.remove(at: beerIndex)
        }
        manufacturerDetailDAO.deleteBeer(beerUUID: uuid, manufacturerUUID: manufacturer.uuid)
    }
    
    func orderBeersBy(orderParam : BeerOrderParam) -> [BeerType: [BeerTableDTO]]{
        
        let beerList = manufacturer.beerList
        var dict = [BeerType : [BeerTableDTO]]()
        var sortedList : [Beer]!
        
        //Add all items to dictionary
        
        switch orderParam {
        case .NAME:
            sortedList = beerList.sorted(by: {$0.name < $1.name})
        case .ALCOHOL:
            sortedList = beerList.sorted(by: {$0.alcoholGraduation < $1.alcoholGraduation})
        case .ENERGY:
            sortedList = beerList.sorted(by: {$0.energy < $1.energy})
        }
        
        for beer in sortedList{
            if dict[beer.type] == nil{
                dict[beer.type] = []
            }
            dict[beer.type]?.append(BeerTableDTO(beer: beer))
        }
        
        if dict[BeerType.OTHER] == nil{
            dict[BeerType.OTHER] = []
        }
        
        return dict
    }
    
}
