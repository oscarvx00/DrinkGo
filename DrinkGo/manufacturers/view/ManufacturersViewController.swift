//
//  ViewController.swift
//  DrinkGo
//
//  Created by Oscar on 9/12/21.
//

import UIKit

class ManufacturersViewController: UIViewController, ManufacturersTableProtocol {

    let MANUFACTURER_DETAIL_SEGUE_ID = "manufacturerDetailSegue"
    
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
        self.performSegue(withIdentifier: MANUFACTURER_DETAIL_SEGUE_ID, sender: manufacturerUUID)
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MANUFACTURER_DETAIL_SEGUE_ID{
            guard let uuid = sender as? UUID else {return}
            let mdvc = segue.destination as! ManufacturerDetailViewController
            mdvc.selectedUUID = uuid
        }
    }



}

