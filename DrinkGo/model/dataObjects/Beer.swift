//
//  Beer.swift
//  Beer
//
//  Created by Oscar on 9/12/21.
//

import Foundation

class Beer : Codable{
    
    var uuid : UUID
    var name : String
    var type : String
    var imageName : String
    var alcoholGraduation : Float
    var energy : Float
    
    init(uuid: UUID, name: String, type: String, imageName: String, alcoholGraduation: Float, energy: Float) {
        self.uuid = uuid
        self.name = name
        self.type = type
        self.imageName = imageName
        self.alcoholGraduation = alcoholGraduation
        self.energy = energy
    }
    
    //TEST
    init(name : String, type : String){
        self.uuid = UUID()
        self.name = name
        self.type = type
        self.alcoholGraduation = 0
        self.imageName = ""
        self.energy = 0
    }
    
}
