//
//  ManufacturerDTO.swift
//  ManufacturerDTO
//
//  Created by Oscar on 10/12/21.
//

import Foundation
import UIKit


class ManufacturerDTO{
    
    var uuid : UUID
    var name : String
    var type : ManufacturerType
    var logoImage : UIImage?
    var logoImageName : String
    var beers : [BeerTableDTO]
    
    init(manufacturer : Manufacturer){
        self.uuid = manufacturer.uuid
        self.name = manufacturer.name
        self.type = manufacturer.type
        self.logoImage = UIImage(contentsOfFile: manufacturer.logoImageName)
        self.logoImageName = manufacturer.logoImageName
        self.beers = manufacturer.beerList.map{
            return BeerTableDTO(beer: $0)
        }
    }
    
}
