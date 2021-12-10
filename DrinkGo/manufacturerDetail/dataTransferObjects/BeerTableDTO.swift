//
//  BeerTableDTO.swift
//  BeerTableDTO
//
//  Created by Oscar on 10/12/21.
//

import Foundation
import UIKit


class BeerTableDTO{
    
    var uuid : UUID
    var name : String
    var type : String
    var image : UIImage?
    
    init(beer : Beer){
        self.uuid = beer.uuid
        self.type = beer.type
        self.name = beer.name
        self.image = UIImage(contentsOfFile: beer.imageName)
    }
    
}
