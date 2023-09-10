//
//  ViewController.swift
//  AutoServeIOS
//
//  Created by Dad's 6,1 on 8/29/23.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, AutoServeDelegate {
    
    var api_manager = API_Manager()
    
    @IBOutlet weak var makePicker: UIPickerView!
    
    @IBOutlet weak var modelPicker: UIPickerView!
    
    @IBOutlet weak var yearPicker: UIPickerView!
    
    var makePickerData = [MakeData]()
    
    var modelPickerData = [ModelData]()
    
    var yearPickerData = ["2023", "2022", "2021", "2020", "2019"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        api_manager.delegate = self
        
        api_manager.fetchMake()
        api_manager.fetchModel()
        
        self.makePicker.delegate = self
        self.makePicker.dataSource = self
        
        self.modelPicker.delegate = self
        self.modelPicker.dataSource = self
        
        self.yearPicker.delegate = self
        self.yearPicker.dataSource = self
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return makePickerData.count
        } else if pickerView.tag == 2 {
            return modelPickerData.count
        } else {
            return yearPickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            let make = makePickerData[row]
            return make.Make_Name
            
        } else if pickerView.tag == 2 {
            let model = modelPickerData[row]
            return model.Model_Name
            
        } else {
            return yearPickerData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func didReceiveMake(makes: [MakeData]) {
        makePickerData = makes
        DispatchQueue.main.async {
            self.makePicker.reloadAllComponents()
        }
        
    }
    func didReceiveModel(models: [ModelData]) {
        modelPickerData = models
        DispatchQueue.main.async {
            self.modelPicker.reloadAllComponents()
        }
    }
}

