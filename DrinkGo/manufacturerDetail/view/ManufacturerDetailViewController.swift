//
//  ManufacturerDetailViewController.swift
//  ManufacturerDetailViewController
//
//  Created by Oscar on 10/12/21.
//

import Foundation
import UIKit


class ManufacturerDetailViewController : UIViewController, ManufacturerDetailPickerViewAdapterProtocol, ManufacturerBeerTableProtocol, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let BEER_DETAIL_SEGUE_ID = "beerDetailSegue"
    
    var selectedUUID : UUID!
    
    let viewModel = ManufacturerDetailViewModel()
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var orderTextField: UITextField!
    @IBOutlet weak var beersTableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    let manufacturerTypePickerView = UIPickerView()
    let beerOrderPickerView = UIPickerView()
    
    var manufacturerTypePickerAdapter : ManufacturerDetailPickerViewAdapterManufacturerType!
    var beerOrderPickerAdapter : ManufacturerDetailPickerViewAdapterBeerOrder!
    var tableAdapter : ManufacturerBeersTableViewAdapter!
    
    var selectedManufacturerType = ManufacturerType.NATIONAL
    var selectedBeerOrder = BeerOrderParam.NAME
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manufacturerTypePickerAdapter = ManufacturerDetailPickerViewAdapterManufacturerType(parent: self)
        beerOrderPickerAdapter = ManufacturerDetailPickerViewAdapterBeerOrder(parent: self)
        
        manufacturerTypePickerView.delegate = manufacturerTypePickerAdapter
        manufacturerTypePickerView.dataSource = manufacturerTypePickerAdapter
        beerOrderPickerView.delegate = beerOrderPickerAdapter
        beerOrderPickerView.dataSource = beerOrderPickerAdapter
        
        typeTextField.inputView = manufacturerTypePickerView
        orderTextField.inputView = beerOrderPickerView
        
        tableAdapter = ManufacturerBeersTableViewAdapter(parent: self)
        beersTableView.delegate = tableAdapter
        beersTableView.dataSource = tableAdapter
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        imageView.addGestureRecognizer(tapGR)
        imageView.isUserInteractionEnabled = true
        
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        
        
        orderTextField.text = selectedBeerOrder.value
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureUI(manufacturer: viewModel.getManufacturer(uuid: selectedUUID))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveState()
    }
    
    
    func optionSelected(obj: Any) {
        switch obj{
        case is ManufacturerType:
            typeTextField.text = (obj as! ManufacturerType).header
            typeTextField.resignFirstResponder()
            selectedManufacturerType = obj as! ManufacturerType
        case is BeerOrderParam:
            orderTextField.text = (obj as! BeerOrderParam).value
            orderTextField.resignFirstResponder()
            selectedBeerOrder = obj as! BeerOrderParam
        default: abort()
        }
    }
    
    private func configureUI(manufacturer : ManufacturerDTO){
        nameTextField.text = manufacturer.name
        typeTextField.text = manufacturer.type.header
        selectedManufacturerType = manufacturer.type
        configureBeersListUI(data: manufacturer.beers)
        if manufacturer.logoImage != nil{
            imageView.image = manufacturer.logoImage
        }
    }
    
    private func configureBeersListUI(data : [BeerTableDTO]){
        tableAdapter.beers = data
        beersTableView.reloadData()
    }
    
    func beerSelected(uuid: UUID) {
        self.performSegue(withIdentifier: BEER_DETAIL_SEGUE_ID, sender: uuid)
    }
    
    func deleteBeer(uuid: UUID) {
        viewModel.deleteBeer(uuid: uuid)
    }
    
    private func saveState(){
        var name = nameTextField.text
        let type = selectedManufacturerType
        var image = imageView.image
        
        if(name != nil && name!.isEmpty){
            name = "NO NAME"
        }
        
        if image == UIImage(systemName: "camera"){
            image = nil
        }
        viewModel.updateManufacturer(name: name!, type: type, image: image)
    }
    
    @IBAction func addBeerClicked(_ sender: Any) {
        let beer = viewModel.addBeer()
        tableAdapter.beers.append(beer)
        beersTableView.beginUpdates()
        beersTableView.insertRows(at: [IndexPath.init(row: tableAdapter.beers.count-1, section: 0)], with: .right)
        beersTableView.endUpdates()
    }
    
    @IBAction func orderBeersClicked(_ sender: Any) {
        configureBeersListUI(data: viewModel.orderBeersBy(orderParam: selectedBeerOrder))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == BEER_DETAIL_SEGUE_ID{
            guard let uuid = sender as? UUID else {return}
            let bdvc = segue.destination as! BeerDetailViewController
            bdvc.selectedManufacturerUUID = viewModel.manufacturer.uuid
            bdvc.selectedBeerUUID = uuid
        }
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
}

class ManufacturerBeersTableViewCell : UITableViewCell{
    
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
}

