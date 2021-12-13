//
//  BeerDetailViewModel.swift
//  BeerDetailViewModel
//
//  Created by Oscar on 12/12/21.
//

import Foundation
import UIKit


class BeerDetailViewModel{
    
    let beerDetailDAO : BeerDetailDAO = DatabaseManager.shared as BeerDetailDAO
    
    var manufacturerUUID : UUID!
    var beer : Beer!
    
    func getBeer(manufacturerUUID : UUID, beerUUID : UUID) -> BeerDTO{
        
        self.manufacturerUUID = manufacturerUUID
        self.beer = beerDetailDAO.getBeer(beerUUID: beerUUID, manufacturerUUID: manufacturerUUID)
        
        return BeerDTO(beer: beer)
    }
    
    func updateBeer(name : String, type : String, alcohol : Float, energy : Float, image : UIImage?){
        beer.name = name
        beer.type = type
        beer.alcoholGraduation = alcohol
        beer.energy = energy
        if image != nil && image != BeerDTO(beer: beer).image{
            beer.imageName = beerDetailDAO.saveImage(image: image!, oldImageName: beer.imageName)
        }
        
        beerDetailDAO.updateBeer(beer: beer, manufacturerUUID: manufacturerUUID)
    }
    
}
