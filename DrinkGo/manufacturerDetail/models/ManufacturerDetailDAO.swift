//
//  ManufacturerDetailDAO.swift
//  ManufacturerDetailDAO
//
//  Created by Oscar on 10/12/21.
//

import Foundation
import UIKit

protocol ManufacturerDetailDAO{
    
    func getManufacturer(uuid : UUID) -> Manufacturer
    func updateManufacturer(manufacturer : Manufacturer)
    func insertEmptyBeerToManufacturer(manufacturerUUID : UUID) -> Beer
    func deleteBeer(beerUUID : UUID, manufacturerUUID : UUID)
    func saveImage(image: UIImage, oldImageName : String) -> String
    
}
