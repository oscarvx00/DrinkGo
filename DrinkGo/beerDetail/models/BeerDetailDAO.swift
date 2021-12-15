//
//  BeerDetailDAO.swift
//  BeerDetailDAO
//
//  Created by Oscar on 12/12/21.
//

import Foundation
import UIKit


protocol BeerDetailDAO{
    
    func getBeer(beerUUID : UUID, manufacturerUUID : UUID) -> Beer
    func updateBeer(beer : Beer, manufacturerUUID : UUID)
    func saveImage(image: UIImage, oldImageName : String) -> String
    
}
