//
//  BeerDetailViewController.swift
//  BeerDetailViewController
//
//  Created by Oscar on 12/12/21.
//

import Foundation
import UIKit


class BeerDetailViewController : UIViewController{
    
    var selectedManufacturerUUID : UUID!
    var selectedBeerUUID : UUID!
    
    let viewModel = BeerDetailViewModel()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var energyTextField: UITextField!
    @IBOutlet weak var alcoholTextField: UITextField!
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureBeerUI(beer: viewModel.getBeer(manufacturerUUID: selectedManufacturerUUID, beerUUID: selectedBeerUUID))
    }
    
    
    private func configureBeerUI(beer : BeerDTO){
        nameTextField.text = beer.name
        typeTextField.text = beer.type
        alcoholTextField.text = String(format: "%.2f", beer.alcoholGraduation)
        energyTextField.text = String(format: "%.2f", beer.energy)
    }
    
    private func saveState(){
        let name = nameTextField.text
        let type = typeTextField.text
        var alcohol : Float? = Float(alcoholTextField.text!)
        var energy : Float? = Float(energyTextField.text!)
        
        if alcohol == nil{
            alcohol = 0.0
        }
        if energy == nil{
            energy = 0.0
        }
        
        viewModel.updateBeer(name: name!, type: type!, alcohol: alcohol!, energy: energy!)
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        saveState()
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
