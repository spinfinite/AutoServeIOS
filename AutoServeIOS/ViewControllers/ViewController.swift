//
//  ViewController.swift
//  AutoServeIOS
//
//  Created by Dad's 6,1 on 8/29/23.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, AutoServeDelegate {
    
    var api_manager = API_Manager()
    
    
    @IBOutlet weak var pilotImageView: UIImageView!
    
    @IBOutlet weak var makePicker: UIPickerView!
    
    //    @IBOutlet weak var modelPicker: UIPickerView!
    
    @IBOutlet weak var yearPicker: UIPickerView!
    
    @IBAction func didTapSubmit(_ sender: Any) {
        
        let makeSelected = makePicker.selectedRow(inComponent: 0)
        let makeValueSelected = makePickerData[makeSelected]
        
        let yearSelected = yearPicker.selectedRow(inComponent: 0)
        let yearValueSelected = yearPickerData[yearSelected]
        
        print("The make and year selected were of the following make: \(makeValueSelected) year: \(yearValueSelected)")
        
        api_manager.fetchMakeYear(make: makeValueSelected.Make_ID, year: yearValueSelected)
        
    }
    var makePickerData = [MakeData]()
    
    //    var modelPickerData = [ModelData]()
    
    var yearPickerData = ["1981","1982","1983","1984","1985","1986","1987","1988","1989","1990","1991","1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020","2021","2022","2023"]
    
    var makeYearData = [VehicleInfo]()
    
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
        
        pilotImageView.heightAnchor.constraint(equalToConstant:pilotImageView.contentClippingRect.height).isActive = true
        
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
    
    func didReceiveVehicleInfo(vehicleInfo: [VehicleInfo]) {
        print(vehicleInfo)
        
        DispatchQueue.main.async {
            
            var modelsFromMake = [String]()
            for individualInfo in vehicleInfo {
                modelsFromMake.append(individualInfo.Model_Name)
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let yearSelected = self.yearPicker.selectedRow(inComponent: 0)
            let yearValueSelected = self.yearPickerData[yearSelected]
            
            let makeSelected = self.makePicker.selectedRow(inComponent: 0)
            let makeValueSelected = self.makePickerData[makeSelected]
            
            if let displayVC = storyboard.instantiateViewController(withIdentifier:"DisplayID") as? DisplayViewController {
                displayVC.year = yearValueSelected
                displayVC.make = makeValueSelected.Make_Name
                displayVC.modelNames = modelsFromMake
                
                self.navigationController?.pushViewController(displayVC, animated: true)
            }
            
        }
    }
    
}

extension UIImageView {
    var contentClippingRect: CGRect {
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }

        let scale: CGFloat
        if image.size.width > image.size.height {
            scale = bounds.width / image.size.width
        } else {
            scale = bounds.height / image.size.height
        }

        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0

        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
}

