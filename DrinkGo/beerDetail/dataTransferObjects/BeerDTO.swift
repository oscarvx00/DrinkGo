//
//  BeerDTO.swift
//  BeerDTO
//
//  Created by Oscar on 12/12/21.
//

import Foundation
import UIKit


class BeerDTO{
    
    var uuid : UUID
    var name : String
    var type : String
    var image : UIImage?
    var imageName : String
    var alcoholGraduation : Float
    var energy : Float
    
    init(beer : Beer){
        self.uuid = beer.uuid
        self.name = beer.name
        self.type = beer.type
        self.image = UIImage(contentsOfFile: beer.imageName)
        self.imageName = beer.imageName
        self.alcoholGraduation = beer.alcoholGraduation
        self.energy = beer.energy
    }
    
}
