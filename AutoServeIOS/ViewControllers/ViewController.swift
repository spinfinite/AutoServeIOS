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
    
//    @IBOutlet weak var modelPicker: UIPickerView!
    
    @IBOutlet weak var yearPicker: UIPickerView!
    
    @IBAction func didTapSubmit(_ sender: Any) {
        
        let makeSelected = makePicker.selectedRow(inComponent: 0)
        let makeValueSelected = makePickerData[makeSelected]
  
        let yearSelected = yearPicker.selectedRow(inComponent: 0)
        let yearValueSelected = yearPickerData[yearSelected]
        
        print("The make and year selected were the following make: \(makeValueSelected) year: \(yearValueSelected)")
        
        api_manager.fetchMakeYear(make: makeValueSelected.Make_ID, year: yearValueSelected)
        
    }
    var makePickerData = [MakeData]()
    
//    var modelPickerData = [ModelData]()
    
    var yearPickerData = ["1981","1982","1983","1984","1985","1986","1987","1988","1989","1990","1991","1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020","2021","2022","2023"]
    
    var makeYearData = [MakeYearData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        api_manager.delegate = self
        
        api_manager.fetchMake()
        
        self.makePicker.delegate = self
        self.makePicker.dataSource = self
        
//        self.modelPicker.delegate = self
//        self.modelPicker.dataSource = self
        
        self.yearPicker.delegate = self
        self.yearPicker.dataSource = self
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return makePickerData.count
//        } else if pickerView.tag == 2 {
//            return modelPickerData.count
        } else {
            return yearPickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            let make = makePickerData[row]
            //print(make.Make_Name)
            return make.Make_Name
            
//        } else if pickerView.tag == 2 {
//
//            let model = modelPickerData[row]
//
//            return model.Model_Name
            
        } else {
            return yearPickerData[row]
        }
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//        if pickerView.tag == 1 {
//            let make = makePickerData[row]
//            api_manager.fetchModel(make: make.Make_ID)
//            print(make.Make_Name)
//        } else if pickerView.tag == 2 {
//
//            let model = modelPickerData[row]
//            print(model.Model_Name)
//        } else if pickerView.tag == 3 {
//            let year = yearPickerData[row]
//            print(year)
//        }
//
//    }
    
    func didReceiveMake(makes: [MakeData]) {
        makePickerData = makes
        DispatchQueue.main.async {
            self.makePicker.reloadAllComponents()
        }
        
    }
//    func didReceiveModel(models: [ModelData]) {
//        modelPickerData = models
//        DispatchQueue.main.async {
//            self.modelPicker.reloadAllComponents()
//        }
//    }
    
    func didReceiveMakeYear(makesYears: [MakeYearData]) {
        print(makesYears)
        
       
    }
    
}

