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
    var type : BeerType
    var image : UIImage?
    
    init(beer : Beer){
        self.uuid = beer.uuid
        self.type = beer.type
        self.name = beer.name
       
        //LOAD IMAGE
        do{
            let documentsDir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let imagePath = documentsDir.appendingPathComponent("images", isDirectory: true).appendingPathComponent(beer.imageName)
            
            self.image = UIImage(contentsOfFile: imagePath.path)
        } catch{
            self.image = nil
        }
    }
    
}
