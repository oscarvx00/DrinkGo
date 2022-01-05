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
    func deleteBeer(uuid : UUID)
}

class ManufacturerBeersTableViewAdapter : NSObject, UITableViewDelegate, UITableViewDataSource{
    
    var beers = [BeerType: [BeerTableDTO]]()
    
    let parent : ManufacturerBeerTableProtocol
    
    init(parent : ManufacturerBeerTableProtocol){
        self.parent = parent
        beers[BeerType.OTHER] = [BeerTableDTO]()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers[Array(beers.keys)[section]]!.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Array(beers.keys).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "manufacturerBeerCell", for: indexPath) as! ManufacturerBeersTableViewCell
        
        let beer = beers[Array(beers.keys)[indexPath.section]]![indexPath.row]
        cell.cellLabel?.text = beer.name
        if beer.image != nil{
            cell.cellImageView?.image = beer.image
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let beer = beers[Array(beers.keys)[indexPath.section]]![indexPath.row]
        
        parent.beerSelected(uuid: beer.uuid) 
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(beers.keys)[section].header
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            let uuid = beers[Array(beers.keys)[indexPath.section]]![indexPath.row].uuid
            beers[Array(beers.keys)[indexPath.section]]!.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
            parent.deleteBeer(uuid: uuid)
        }
    }
    
    
}
