//
//  DisplayViewController.swift
//  AutoServeIOS
//
//  Created by Dad's 6,1 on 9/13/23.
//

import UIKit

class DisplayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
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
        
        configureTableView()
        
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    }
    
    
    @IBOutlet weak var displayModelsTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modelNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "modelCells", for: indexPath)
        cell.textLabel?.text = modelNames[indexPath.row]
        
        return cell
    }
    
    func configureTableView() {
        displayModelsTableView.dataSource = self
        displayModelsTableView.delegate = self
    }
    
    
    @IBAction func addToFavoritesButton(_ sender: Any) {
        
        print("This where favorites will be")
        //create tab bar controller
        
                
    }

}
