//
//  ManufacturersTableViewController.swift
//  ManufacturersTableViewController
//
//  Created by Oscar on 9/12/21.
//

import Foundation
import UIKit


class ManufacturersTableViewController : UITableViewDataSource, UITableViewDelegate{
    
    var manufacturers = [ManufacturerType : [ManufacturersTableDTO]]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manufacturers[manufacturers.keys[section]].count
    }
    
}
