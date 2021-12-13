//
//  Manufacturer.swift
//  Manufacturer
//
//  Created by Oscar on 9/12/21.
//

import Foundation


class Manufacturer : Codable{
    
    var uuid : UUID
    var name : String
    var type : ManufacturerType
    var logoImageName : String
    var beerList : [Beer]
    
    init(uuid : UUID, name : String, type : ManufacturerType, logoImageName : String, beerList : [Beer]){
        self.uuid = uuid
        self.name = name
        self.type = type
        self.logoImageName = logoImageName
        self.beerList = beerList
    }
    
    init(){
        self.uuid = UUID()
        self.name = ""
        self.type = ManufacturerType.NATIONAL
        self.logoImageName = ""
        self.beerList = []
    }
    
    //TEST
    init(name : String, type : ManufacturerType, beers : [Beer]){
        self.uuid = UUID()
        self.name = name
        self.type = type
        self.logoImageName = ""
        self.beerList = beers
    }
    
}
