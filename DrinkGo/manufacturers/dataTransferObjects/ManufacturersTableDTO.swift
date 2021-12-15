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
