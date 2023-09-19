//
//  DisplayViewController.swift
//  AutoServeIOS
//
//  Created by Dad's 6,1 on 9/13/23.
//

import UIKit

class DisplayViewController: UIViewController{
    
    @IBOutlet weak var modelsAndMakesTitle: UILabel!
    
    @IBOutlet weak var displayModelsForMakeAndYear: UILabel!
    
    var year = ""
    var make = ""
    var modelNames = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modelsAndMakesTitle?.text = "Models for Make and Year List"
        
        displayModelsForMakeAndYear?.text = "The models for make \(make) and year \(year) are: "
        
        print(year, make, modelNames)
        
    }
    
    
    
    
    
    
    
    
}
