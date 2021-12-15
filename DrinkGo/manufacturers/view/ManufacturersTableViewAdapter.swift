//
//  ManufacturersTableViewController.swift
//  ManufacturersTableViewController
//
//  Created by Oscar on 9/12/21.
//

import Foundation
import UIKit

protocol ManufacturersTableProtocol{
    func manufacturerSelected(manufacturerUUID : UUID)
    func deleteManufacturer(manufacturerUUID : UUID)
}

class ManufacturersTableViewAdapter : NSObject, UITableViewDataSource, UITableViewDelegate{
    
    var manufacturers : [ManufacturerType : [ManufacturersTableDTO]]
    
    let parent : ManufacturersTableProtocol
    
    init(parent : ManufacturersTableProtocol){
        
        self.parent = parent
        
        manufacturers = [ManufacturerType : [ManufacturersTableDTO]]()
        manufacturers[ManufacturerType.NATIONAL] = [ManufacturersTableDTO]()
        manufacturers[ManufacturerType.IMPORTED] = [ManufacturersTableDTO]()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manufacturers[Array(manufacturers.keys)[section]]!.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return Array(manufacturers.keys).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "manufacturersCell", for: indexPath) as! ManufacturersTableViewCell
        
        let manufacturer = manufacturers[Array(manufacturers.keys)[indexPath.section]]![indexPath.row]
        cell.cellLabel?.text = manufacturer.name
        if manufacturer.logoImage != nil{
            cell.cellImageView?.image = manufacturer.logoImage
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(manufacturers.keys)[section].header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let manufacturer = manufacturers[Array(manufacturers.keys)[indexPath.section]]![indexPath.row]
        
        parent.manufacturerSelected(manufacturerUUID: manufacturer.uuid)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            let uuid = manufacturers[Array(manufacturers.keys)[indexPath.section]]![indexPath.row].uuid
            manufacturers[Array(manufacturers.keys)[indexPath.section]]!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            parent.deleteManufacturer(manufacturerUUID: uuid)
        }
    }
    
}
