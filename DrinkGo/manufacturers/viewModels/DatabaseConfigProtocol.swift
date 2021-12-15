//
//  DatabaseConfigProtocol.swift
//  DatabaseConfigProtocol
//
//  Created by Oscar on 9/12/21.
//

import Foundation


protocol DatabaseConfigProtocol{
    func openDatabase() -> Bool
    func closeDatabase()
}
