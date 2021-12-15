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
    var beers : [BeerTableDTO]
    
    init(manufacturer : Manufacturer){
        self.uuid = manufacturer.uuid
        self.name = manufacturer.name
        self.type = manufacturer.type
        self.beers = manufacturer.beerList.map{
            return BeerTableDTO(beer: $0)
        }
         
        //LOAD IMAGE
        do{
            let documentsDir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

            
            let imagePath = documentsDir.appendingPathComponent("images", isDirectory: true).appendingPathComponent(manufacturer.logoImageName)
            
            self.logoImage = UIImage(contentsOfFile: imagePath.path)
        } catch{
            self.logoImage = nil
        }
    }
}
