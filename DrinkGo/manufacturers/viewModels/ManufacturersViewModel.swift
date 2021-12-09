//
//  ManufacturersViewModel.swift
//  ManufacturersViewModel
//
//  Created by Oscar on 9/12/21.
//

import Foundation

class ManufacturersViewModel{
    
    let manufacturersDAO : ManufacturersDAO = DatabaseManager.shared as ManufacturersDAO
    let databaseConfig : DatabaseConfigProtocol = DatabaseManager.shared as DatabaseConfigProtocol
    
}
