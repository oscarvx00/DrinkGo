//
//  BeerType.swift
//  BeerType
//
//  Created by Oscar on 5/1/22.
//

import Foundation

enum BeerType : CaseIterable, Codable{
    case LAGER
    case PILSEN
    case IPA
    case PALE_ALE
    case OTHER
    
    var header : String{
        switch self{
        case .LAGER: return "Lager"
        case .PILSEN: return "Pilsen"
        case .IPA: return "Ipa"
        case .PALE_ALE: return "Pale Ale"
        case .OTHER: return "Otro"
        }
    }
}
