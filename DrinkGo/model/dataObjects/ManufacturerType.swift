//
//  ManufacturerType.swift
//  ManufacturerType
//
//  Created by Oscar on 9/12/21.
//

import Foundation


enum ManufacturerType : CaseIterable, Codable{
    case NATIONAL
    case INTERNATIONAL
    
    var header : String {
        switch self{
        case .NATIONAL: return "National"
        case .INTERNATIONAL : return "International"
        }
    }
}
