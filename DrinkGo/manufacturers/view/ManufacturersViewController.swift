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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureUI(manufacturers: viewModel.getManufacturers())
    }
    
    private func configureUI(manufacturers : [ManufacturerType : [ManufacturersTableDTO]]){
        tableAdapter.manufacturers = manufacturers
        table.reloadData()
    }
    
    func manufacturerSelected(manufacturerUUID: UUID) {
        self.performSegue(withIdentifier: MANUFACTURER_DETAIL_SEGUE_ID, sender: manufacturerUUID)
        //goToManufacturerDetail(uuid: manufacturerUUID)
    }
    
    func goToManufacturerDetail(uuid : UUID){
        let mdvc = ManufacturerDetailViewController()
        mdvc.selectedUUID = uuid
        self.present(mdvc, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MANUFACTURER_DETAIL_SEGUE_ID{
            guard let uuid = sender as? UUID else {return}
            let mdvc = segue.destination as! ManufacturerDetailViewController
            mdvc.selectedUUID = uuid
        }
    }

    @IBAction func addManufacturerClicked(_ sender: Any) {
        let uuid = viewModel.addManufacturer()
        self.performSegue(withIdentifier: MANUFACTURER_DETAIL_SEGUE_ID, sender: uuid)
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Warning", message: "All data will be lost", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action: UIAlertAction!) in abort()}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func deleteManufacturer(manufacturerUUID: UUID) {
        table.reloadData()
        print("DELETE")
    }
    
    
}

