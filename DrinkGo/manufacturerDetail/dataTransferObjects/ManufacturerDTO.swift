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
    var beers : [BeerType :[BeerTableDTO]]
    
    init(manufacturer : Manufacturer){
        self.uuid = manufacturer.uuid
        self.name = manufacturer.name
        self.type = manufacturer.type
        self.beers = [BeerType : [BeerTableDTO]]()
        
        for manBeer in manufacturer.beerList{
            if beers[manBeer.type] == nil {
                beers[manBeer.type] = []
            }
            self.beers[manBeer.type]?.append(BeerTableDTO(beer: manBeer))
        }
        
        if self.beers[BeerType.OTHER] == nil{
            self.beers[BeerType.OTHER] = []
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
