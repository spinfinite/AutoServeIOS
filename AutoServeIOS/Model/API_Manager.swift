//
//  API_Manager.swift
//  AutoServeIOS
//
//  Created by Dad's 6,1 on 9/1/23.
//

import Foundation

protocol AutoServeDelegate {
    
    func didReceiveMake(makes: [MakeData])
    func didReceiveModel(models: [ModelData])
}

struct API_Manager {
    
    let baseURL = "https://vpic.nhtsa.dot.gov/api/vehicles/"
    
    var delegate: AutoServeDelegate?
    
    func fetchMake() {
        let urlMakeString = "\(baseURL)getallmakes?format=json"
        performRequest(urlModelString: urlMakeString)
    }
    
    func performRequest(urlModelString: String) {
        // 1. Create URL
        if let url = URL(string: urlModelString) {
            // 2. Create URL Session
            let session = URLSession(configuration: .default)
            // 3. Give URLSession a task
            let task = session.dataTask(with: url) {
                (data, URLResponse, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    let resultData = self.parseJSON(vehicleData: safeData)
                    delegate?.didReceiveMake(makes: resultData)
                }
            }
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(vehicleData: Data) -> [MakeData] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MakeContainer.self, from: vehicleData)
            
            return decodedData.Results
        } catch {
            print(error)
            return []
        }
    }
    
}
