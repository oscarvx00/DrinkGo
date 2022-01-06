//
//  BeerDetailViewController.swift
//  BeerDetailViewController
//
//  Created by Oscar on 12/12/21.
//

import Foundation
import UIKit


class BeerDetailViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, BeerDetailPickerViewAdapterProtocol{
    
    var selectedManufacturerUUID : UUID!
    var selectedBeerUUID : UUID!
    
    let viewModel = BeerDetailViewModel()
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var energyTextField: UITextField!
    @IBOutlet weak var alcoholTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    let beerTypePickerView = UIPickerView()
    var beerTypePickerAdapter : BeerDetailPickerViewAdapter!
    
    var selectedBeerType = BeerType.OTHER
    
    override func loadView() {
        super.loadView()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        imageView.addGestureRecognizer(tapGR)
        imageView.isUserInteractionEnabled = true
        
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        //imagePicker.allowsEditing = false
        
        beerTypePickerAdapter = BeerDetailPickerViewAdapter(parent: self)
        beerTypePickerView.delegate = beerTypePickerAdapter
        beerTypePickerView.dataSource = beerTypePickerAdapter
        
        typeTextField.inputView = beerTypePickerView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureBeerUI(beer: viewModel.getBeer(manufacturerUUID: selectedManufacturerUUID, beerUUID: selectedBeerUUID))
    }
    
    
    private func configureBeerUI(beer : BeerDTO){
        nameTextField.text = beer.name
        typeTextField.text = beer.type.header
        selectedBeerType = beer.type
        alcoholTextField.text = String(format: "%.2f", beer.alcoholGraduation)
        energyTextField.text = String(format: "%.2f", beer.energy)
        if beer.image != nil{
            imageView.image = beer.image
        }
    }
    
    private func saveState(){
        
        let name = nameTextField.text
        let type = selectedBeerType
        var alcohol : Float? = Float(alcoholTextField.text!)
        var energy : Float? = Float(energyTextField.text!)
        var image = imageView.image
        
        if alcohol == nil{
            alcohol = 0.0
        }
        if energy == nil{
            energy = 0.0
        }
        
        if image == UIImage(systemName: "camera"){
            image = nil
        }
        
        viewModel.updateBeer(name: name!, type: type, alcohol: alcohol!, energy: energy!, image: image)
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        saveState()
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imageTapped(sender : UITapGestureRecognizer){
        if sender.state == .ended{
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func optionSelected(obj: BeerType) {
        typeTextField.text = obj.header
        typeTextField.resignFirstResponder()
        selectedBeerType = obj
    }
}
