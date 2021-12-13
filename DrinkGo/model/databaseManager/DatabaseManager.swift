//
//  DatabaseManager.swift
//  DatabaseManager
//
//  Created by Oscar on 9/12/21.
//

import Foundation
import UIKit

class DatabaseManager : DatabaseConfigProtocol, ManufacturersDAO, ManufacturerDetailDAO, BeerDetailDAO{

    let storageFileName = "drinkgoData.txt"
    let storageDirectoryName = "data"
    
    let imagesDirectoryName = "images"
    
    let fileManager = FileManager.default
    
    var manufacturers = [Manufacturer]()
    
    static var shared : DatabaseManager = {
        let instance = DatabaseManager()
        return instance
    }()
    
    func openDatabase() -> Bool {
        //CHECK IF FILE EXISTS, IF NOT READ DEFAULT DATA AND CREATE DATA DIRECTORY
        if !readStoredData(){
            createDataDirectory()
            readDefaultData()
        }
        
        return true
    }
    
    private func readDefaultData(){
        
        if let defaultDataFileUrl = Bundle.main.url(forResource: "defaultData", withExtension: "txt"){
            do{
                let data = try String(contentsOf: defaultDataFileUrl, encoding: .utf8).data(using: .utf8)!
                
                manufacturers = try JSONDecoder().decode([Manufacturer].self, from: data)
            } catch let error{
                print(error.localizedDescription)
            }
        }
    }
    
    private func readStoredData() -> Bool{
        do{
            let fileURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent(storageDirectoryName)
                .appendingPathComponent(storageFileName)
            
            let data = try String(contentsOf: fileURL, encoding: .utf8).data(using: .utf8)!
            
            manufacturers = try JSONDecoder().decode([Manufacturer].self, from: data)
            
        } catch let error{
            print(error.localizedDescription)
            return false
        }
        return true
    }
    
    private func createDataDirectory(){
        do{
            let documentsPath = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            
            let dataDirURL = documentsPath.appendingPathComponent(storageDirectoryName)
            if !fileManager.fileExists(atPath: dataDirURL.path){
                try fileManager.createDirectory(atPath: dataDirURL.path, withIntermediateDirectories: true, attributes: nil)
            }
            
            //Create images directory
            let imagesDirURL = documentsPath.appendingPathComponent(imagesDirectoryName)
            if !fileManager.fileExists(atPath: imagesDirURL.path){
                try fileManager.createDirectory(atPath: imagesDirURL.path, withIntermediateDirectories: true, attributes: nil)
            }
            
        } catch let error{
            print(error.localizedDescription)
        }
    }
    
    func closeDatabase() {
        //SAVING DATA
        
        var jsonString : String = "NO DATA"
        
        do{
            let jsonData = try JSONEncoder().encode(manufacturers)
            jsonString = String(data: jsonData, encoding: .utf8)!
        } catch let error {
            print(error.localizedDescription)
        }
        
        do{
            let fileURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent(storageDirectoryName)
                .appendingPathComponent(storageFileName)
            
            try jsonString.write(to: fileURL, atomically: false, encoding: .utf8)
        } catch let error{
            print("CLOSE DATABASE ERROR: \(error.localizedDescription)")
        }
    }
    
    func getManufacturers() -> [Manufacturer] {
        return self.manufacturers
    }
    
    func insertEmptyManufacturer() -> UUID {
        let manufacturer = Manufacturer()
        manufacturers.append(manufacturer)
        return manufacturer.uuid
    }
    
    func deleteManufacturer(uuid: UUID) {
        if let index = manufacturers.firstIndex(where: {$0.uuid == uuid}){
            deleteImage(imageName: manufacturers[index].logoImageName)
            manufacturers.remove(at: index)
        }
    }

    func getManufacturer(uuid: UUID) -> Manufacturer {
        for m in manufacturers{
            if m.uuid == uuid{
                return m
            }
        }
        
        //TODO: CHECK ERROR
        return manufacturers[0]
    }

    func updateManufacturer(manufacturer: Manufacturer) {
        if let i = manufacturers.firstIndex(where: { $0.uuid == manufacturer.uuid}){
            manufacturers[i] = manufacturer
        }
    }

    func insertEmptyBeerToManufacturer(manufacturerUUID: UUID) -> Beer {
        let beer = Beer(name: "Name...", type: "Type...")
        if let index = manufacturers.firstIndex(where: {$0.uuid == manufacturerUUID}){
            manufacturers[index].beerList.append(beer)
        }
        return beer
    }

    func deleteBeer(beerUUID: UUID, manufacturerUUID: UUID) {
        if let parentIndex = manufacturers.firstIndex(where: {$0.uuid == manufacturerUUID}){
            if let beerIndex = manufacturers[parentIndex].beerList.firstIndex(where: {$0.uuid == beerUUID}){
                deleteImage(imageName: manufacturers[parentIndex].beerList[beerIndex].imageName)
                manufacturers[parentIndex].beerList.remove(at: beerIndex)
            }
        }
    }
    
    func getBeer(beerUUID: UUID, manufacturerUUID: UUID) -> Beer {
        if let parent = manufacturers.first(where: {$0.uuid == manufacturerUUID}){
            if let beer = parent.beerList.first(where: {$0.uuid == beerUUID}){
                return beer
            }
        }
        
        //ERROR CASE
        return manufacturers[0].beerList[0]
    }
    
    func updateBeer(beer: Beer, manufacturerUUID: UUID) {
        if let parentIndex = manufacturers.firstIndex(where: {$0.uuid == manufacturerUUID}){
            if let beerIndex = manufacturers[parentIndex].beerList.firstIndex(where: {$0.uuid == beer.uuid}){
                manufacturers[parentIndex].beerList[beerIndex] = beer
            }
        }
    }
    
    func saveImage(image: UIImage, oldImageName : String) -> String {
        
        let imageName = "\(UUID().uuidString).png"
        
        do{
            let fileUrl = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent(imagesDirectoryName)
                .appendingPathComponent(imageName)
            
            if let data = image.pngData(){
                try data.write(to: fileUrl)
            } else{
                return ""
            }
            
        } catch let error{
            print(error.localizedDescription)
            
            return ""
        }
        
        if !oldImageName.isEmpty{
            deleteImage(imageName: oldImageName)
        }
        
        return imageName
    }
    
    private func deleteImage(imageName : String){
        
        do{
            let fileURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent(imagesDirectoryName)
                .appendingPathComponent(imageName)
            
            try fileManager.removeItem(atPath: fileURL.path)
        } catch let error{
            print(error.localizedDescription)
        }
    }
}
