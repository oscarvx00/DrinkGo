//
//  ManufacturerDetailViewController.swift
//  ManufacturerDetailViewController
//
//  Created by Oscar on 10/12/21.
//

import Foundation
import UIKit


class ManufacturerDetailViewController : UIViewController, ManufacturerDetailPickerViewAdapterProtocol, ManufacturerBeerTableProtocol{
    
    var selectedUUID : UUID!
    
    let viewModel = ManufacturerDetailViewModel()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var orderTextField: UITextField!
    @IBOutlet weak var beersTableView: UITableView!
    
    let manufacturerTypePickerView = UIPickerView()
    let beerOrderPickerView = UIPickerView()
    
    var manufacturerTypePickerAdapter : ManufacturerDetailPickerViewAdapterManufacturerType!
    var beerOrderPickerAdapter : ManufacturerDetailPickerViewAdapterBeerOrder!
    var tableAdapter : ManufacturerBeersTableViewAdapter!
    
    var selectedManufacturerType = ManufacturerType.NATIONAL
    var selectedBeerOrder = BeerOrderParam.NAME
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manufacturerTypePickerAdapter = ManufacturerDetailPickerViewAdapterManufacturerType(parent: self)
        beerOrderPickerAdapter = ManufacturerDetailPickerViewAdapterBeerOrder(parent: self)
        
        manufacturerTypePickerView.delegate = manufacturerTypePickerAdapter
        manufacturerTypePickerView.dataSource = manufacturerTypePickerAdapter
        beerOrderPickerView.delegate = beerOrderPickerAdapter
        beerOrderPickerView.dataSource = beerOrderPickerAdapter
        
        typeTextField.inputView = manufacturerTypePickerView
        orderTextField.inputView = beerOrderPickerView
        
        tableAdapter = ManufacturerBeersTableViewAdapter(parent: self)
        beersTableView.delegate = tableAdapter
        beersTableView.dataSource = tableAdapter
        
        orderTextField.text = selectedBeerOrder.value
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureUI(manufacturer: viewModel.getManufacturer(uuid: selectedUUID))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveState()
    }
    
    
    func optionSelected(obj: Any) {
        switch obj{
        case is ManufacturerType:
            typeTextField.text = (obj as! ManufacturerType).header
            typeTextField.resignFirstResponder()
            selectedManufacturerType = obj as! ManufacturerType
        case is BeerOrderParam:
            orderTextField.text = (obj as! BeerOrderParam).value
            orderTextField.resignFirstResponder()
            selectedBeerOrder = obj as! BeerOrderParam
        default: abort()
        }
    }
    
    private func configureUI(manufacturer : ManufacturerDTO){
        nameTextField.text = manufacturer.name
        typeTextField.text = manufacturer.type.header
        selectedManufacturerType = manufacturer.type
        configureBeersListUI(data: manufacturer.beers)
    }
    
    private func configureBeersListUI(data : [BeerTableDTO]){
        tableAdapter.beers = data
        beersTableView.reloadData()
    }
    
    func beerSelected(uuid: UUID) {
        
    }
    
    private func saveState(){
        var name = nameTextField.text
        let type = selectedManufacturerType
        
        if(name != nil && name!.isEmpty){
            name = "NO NAME"
        }
        viewModel.updateManufacturer(name: name!, type: type)
    }
    
    
}

