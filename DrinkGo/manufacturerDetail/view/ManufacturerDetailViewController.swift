//
//  ManufacturerDetailViewController.swift
//  ManufacturerDetailViewController
//
//  Created by Oscar on 10/12/21.
//

import Foundation
import UIKit


class ManufacturerDetailViewController : UIViewController, ManufacturerDetailPickerViewAdapterProtocol{
    
    var selectedUUID : UUID!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var orderTextField: UITextField!
    let manufacturerTypePickerView = UIPickerView()
    let beerOrderPickerView = UIPickerView()
    
    var manufacturerTypePickerAdapter : ManufacturerDetailPickerViewAdapterManufacturerType!
    var beerOrderPickerAdapter : ManufacturerDetailPickerViewAdapterBeerOrder!
    
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
    }
    
    
    func optionSelected(obj: Any) {
        switch obj{
        case is ManufacturerType:
            typeTextField.text = (obj as! ManufacturerType).header
            typeTextField.resignFirstResponder()
        case is BeerOrderParam:
            orderTextField.text = (obj as! BeerOrderParam).value
            orderTextField.resignFirstResponder()
        default: abort()
        }
    }
    
}

