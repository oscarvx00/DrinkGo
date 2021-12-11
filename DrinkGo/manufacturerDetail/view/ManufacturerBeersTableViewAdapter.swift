//
//  ManufacturerBeersTableViewAdapter.swift
//  ManufacturerBeersTableViewAdapter
//
//  Created by Oscar on 11/12/21.
//

import Foundation
import UIKit


protocol ManufacturerBeerTableProtocol{
    func beerSelected(uuid : UUID)
}

class ManufacturerBeersTableViewAdapter : NSObject, UITableViewDelegate, UITableViewDataSource{
    
    var beers = [BeerTableDTO]()
    
    let parent : ManufacturerBeerTableProtocol
    
    init(parent : ManufacturerBeerTableProtocol){
        self.parent = parent
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "manufacturerBeerCell", for: indexPath)
        
        let beer = beers[indexPath.row]
        cell.textLabel?.text = beer.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let beer = beers[indexPath.row]
        
        parent.beerSelected(uuid: beer.uuid)
    }
    
}
