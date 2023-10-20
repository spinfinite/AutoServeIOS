//
//  CoreDataManager.swift
//  AutoServeIOS
//
//  Created by Dad's 6,1 on 9/26/23.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AutoServeIOS")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    func addVehicle(make: String, model: String, year: String) {
        
        let vehicle = Vehicle(context: persistentContainer.viewContext)
        vehicle.make = make
        vehicle.vehicleModel = model
        vehicle.year = year
        saveContext()
    }
    
    func deleteVehicle(vehicle: Vehicle) {
        
        persistentContainer.viewContext.delete(vehicle)
        try! persistentContainer.viewContext.save()
        
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func fetchFavoriteVehicles() -> [Vehicle] {
        
        let fetchFavoritesRequest = NSFetchRequest<Vehicle>(entityName: "Vehicle")
            print(fetchFavoritesRequest)
        
        do {
            return try persistentContainer.viewContext.fetch(fetchFavoritesRequest)
            
        } catch {
            return []
        }
    }
    
}
