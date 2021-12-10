//
//  ViewController.swift
//  DrinkGo
//
//  Created by Oscar on 9/12/21.
//

import UIKit

class ManufacturersViewController: UIViewController, ManufacturersTableProtocol {

    
    @IBOutlet var table : UITableView!
    
    let viewModel = ManufacturersViewModel()
    
    var tableAdapter : ManufacturersTableViewAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableAdapter = ManufacturersTableViewAdapter(parent: self)
        table.dataSource = tableAdapter
        table.delegate = tableAdapter
        
        
        configureUI(manufacturers: viewModel.getManufacturers())
    }
    
    private func configureUI(manufacturers : [ManufacturerType : [ManufacturersTableDTO]]){
        tableAdapter.manufacturers = manufacturers
        table.reloadData()
    }
    
    func manufacturerSelected(manufacturerUUID: UUID) {
        print("CLICKED")
    }


}

