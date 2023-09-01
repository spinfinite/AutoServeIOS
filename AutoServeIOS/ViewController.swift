//
//  ViewController.swift
//  AutoServeIOS
//
//  Created by Dad's 6,1 on 8/29/23.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let api_manager = API_Manager()
    
    @IBOutlet weak var makePicker: UIPickerView!
    
    @IBOutlet weak var modelPicker: UIPickerView!
    
    @IBOutlet weak var yearPicker: UIPickerView!
    
    var makePickerData = ["Honda", "Toyota", "Subaru", "Chevrolet", "Ford", "Tesla"]
    
    var modelPickerData = ["Accord", "Siena", "Camaro", "F150", "Impressa"]
    
    var yearPickerData = ["2023", "2022", "2021", "2020", "2019"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        api_manager.fetchMake()
        
        self.makePicker.delegate = self
        self.makePicker.dataSource = self
        
        self.modelPicker.delegate = self
        self.modelPicker.dataSource = self
        
        self.yearPicker.delegate = self
        self.yearPicker.dataSource = self
        
        makePicker.    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return makePickerData[component].count
        } else if pickerView.tag == 2 {
            return modelPickerData[component].count
        } else {
            return yearPickerData[component].count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return makePickerData[row]
        } else if pickerView.tag == 1 {
            return modelPickerData[row]
        } else {
            return yearPickerData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
}

