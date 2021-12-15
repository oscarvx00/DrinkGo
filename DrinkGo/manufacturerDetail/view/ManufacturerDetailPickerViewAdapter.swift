//
//  ManufacturerDetailPickerViewAdapter.swift
//  ManufacturerDetailPickerViewAdapter
//
//  Created by Oscar on 10/12/21.
//

import Foundation
import UIKit


protocol ManufacturerDetailPickerViewAdapterProtocol{
    func optionSelected(obj : Any)
}


class ManufacturerDetailPickerViewAdapterManufacturerType : NSObject, UIPickerViewDelegate, UIPickerViewDataSource{
    
    let parent : ManufacturerDetailPickerViewAdapterProtocol
    
    init(parent : ManufacturerDetailPickerViewAdapterProtocol){
        self.parent = parent
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ManufacturerType.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ManufacturerType.allCases[row].header
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        parent.optionSelected(obj: ManufacturerType.allCases[row])
    }
    
}

class ManufacturerDetailPickerViewAdapterBeerOrder : NSObject, UIPickerViewDelegate, UIPickerViewDataSource{
    
    let parent : ManufacturerDetailPickerViewAdapterProtocol
    
    init(parent : ManufacturerDetailPickerViewAdapterProtocol){
        self.parent = parent
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return BeerOrderParam.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return BeerOrderParam.allCases[row].value
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        parent.optionSelected(obj: BeerOrderParam.allCases[row])
    }
    
}
