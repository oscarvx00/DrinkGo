//
//  BeerOrderParam.swift
//  BeerOrderParam
//
//  Created by Oscar on 9/12/21.
//

import Foundation

enum BeerOrderParam : CaseIterable{
    
    case NAME
    case ALCOHOL
    case ENERGY
    
    var value : String{
        switch self{
        case .NAME: return "Name"
        case .ALCOHOL: return "Alcohol"
        case .ENERGY: return "Energy"
        }
    }
}
