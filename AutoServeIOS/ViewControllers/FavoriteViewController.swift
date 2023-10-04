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
        
        favoriteVehicles = coreData.fetchFavoriteVehicles()
        configureTableView()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favoriteVehicles.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCells", for: indexPath)
        cell.textLabel?.text = favoriteVehicles[indexPath.row].make
        return cell
    }
    
    func configureTableView() {
        FavoritesTableView.dataSource = self
        FavoritesTableView.delegate = self
    }
    
    
}
