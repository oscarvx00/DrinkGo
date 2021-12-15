//
//  ManufacturerType.swift
//  ManufacturerType
//
//  Created by Oscar on 9/12/21.
//

import Foundation


enum ManufacturerType : CaseIterable, Codable{
    case NATIONAL
    case IMPORTED
    
    var header : String {
        switch self{
        case .NATIONAL: return "Nacional"
        case .IMPORTED : return "Importada"
        }
    }
}
