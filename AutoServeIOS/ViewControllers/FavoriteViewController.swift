//
//  FavoriteViewController.swift
//  AutoServeIOS
//
//  Created by Dad's 6,1 on 9/25/23.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var AutoServeLogo: UIImageView!
    
    @IBOutlet weak var FavoriteModelsLabel: UILabel!
    
    @IBOutlet weak var FavoritesTableView: UITableView!
    
    let coreData = CoreDataManager.shared
    
    var favoriteVehicles = [Vehicle]()

  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteVehicles = coreData.fetchFavoriteVehicles()
        FavoritesTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favoriteVehicles.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCells", for: indexPath) as! FavoritesCell
        cell.makeLabel.text = favoriteVehicles[indexPath.row].make
        cell.modelLabel.text = favoriteVehicles[indexPath.row].vehicleModel
        cell.yearLabel.text = favoriteVehicles[indexPath.row].year
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let vehicle = favoriteVehicles[indexPath.row]
        
        return UISwipeActionsConfiguration(actions: [UIContextualAction(style: .destructive, title: "unfavorite", handler: {_,_,done in
            self.coreData.deleteVehicle(vehicle: vehicle)
            
            self.favoriteVehicles = self.coreData.fetchFavoriteVehicles()
            self.FavoritesTableView.beginUpdates()
            self.FavoritesTableView.deleteRows(at: [indexPath], with: .automatic)
            self.FavoritesTableView.endUpdates()
            
            done(true)
            })
                                                    
        ])
    }
    
    
    func configureTableView() {
        FavoritesTableView.dataSource = self
        FavoritesTableView.delegate = self
    }
    
    
}
