//
//  BeerDetailPickerViewAdapter.swift
//  BeerDetailPickerViewAdapter
//
//  Created by Oscar on 5/1/22.
//

import Foundation
import UIKit


protocol BeerDetailPickerViewAdapterProtocol{
    func optionSelected(obj : BeerType)
}


class BeerDetailPickerViewAdapter : NSObject, UIPickerViewDelegate, UIPickerViewDataSource{
    
    let parent : BeerDetailPickerViewAdapterProtocol
    
    init(parent : BeerDetailPickerViewAdapterProtocol){
        self.parent = parent
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return BeerType.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return BeerType.allCases[row].header
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        parent.optionSelected(obj: BeerType.allCases[row])
    }
    
}

