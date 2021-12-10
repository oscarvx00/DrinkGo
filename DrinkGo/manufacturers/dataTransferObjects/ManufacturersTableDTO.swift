//
//  ManufacturersTableDTO.swift
//  ManufacturersTableDTO
//
//  Created by Oscar on 9/12/21.
//

import Foundation
import UIKit

class ManufacturersTableDTO{
    
    var uuid : UUID
    var name : String
    var logoImage : UIImage?
    
    init(manufacturer : Manufacturer){
        self.uuid = manufacturer.uuid
        self.name = manufacturer.name
        self.logoImage = UIImage(contentsOfFile: manufacturer.logoImageName)
    }
    
    //TEST METHOD
    init(name : String){
        uuid = UUID()
        self.name = name
        self.logoImage = nil
    }
    
}
