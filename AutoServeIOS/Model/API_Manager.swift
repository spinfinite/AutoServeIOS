//
//  API_Manager.swift
//  AutoServeIOS
//
//  Created by Dad's 6,1 on 9/1/23.
//

import Foundation

protocol AutoServeDelegate {
    
    func didReceiveMake(makes: [MakeData])
//    func didReceiveModel(models: [ModelData])
    func didReceiveVehicleInfo(vehicleInfo: [VehicleInfo])

}

struct API_Manager {
    
    let baseURL = "https://vpic.nhtsa.dot.gov/api/vehicles/"
    
    var delegate: AutoServeDelegate?
    
    func fetchMake() {
        let urlMakeString = "\(baseURL)getallmakes?format=json"
        performRequest(urlMakeString: urlMakeString)
    }
    
    func performRequest(urlMakeString: String) {
        // 1. Create URL
        if let url = URL(string: urlMakeString) {
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
                    let resultData = self.parseJSON(makeData: safeData)
                    delegate?.didReceiveMake(makes: resultData)
                }
            }
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(makeData: Data) -> [MakeData] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MakeContainer.self, from: makeData)
            
            return decodedData.Results
        } catch {
            print(error)
            return []
        }
    }
    
//    func fetchModel(make: Int) {
//        let urlModelString = "\(baseURL)GetModelsForMakeID/\(make)?format=json"
//        performRequest(urlModelString: urlModelString)
//    }
//
//    func performRequest(urlModelString: String) {
//        // 1. Create URL
//        print(urlModelString)
//        if let url = URL(string: urlModelString) {
//            // 2. Create URL Session
//            let session = URLSession(configuration: .default)
//            // 3. Give URLSession a task
//            let task = session.dataTask(with: url) {
//                (data, URLResponse, error) in
//                if error != nil {
//                    print(error!)
//                    return
//                }
//                if let safeData = data {
//                    let modelResultData = self.parseJSON(modelData: safeData)
//                    delegate?.didReceiveModel(models: modelResultData)
//                }
//            }
//            // 4. Start the task
//            task.resume()
//        }
//    }
//
//    func parseJSON(modelData: Data) -> [ModelData] {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(ModelContainer.self, from: modelData)
//
//            return decodedData.Results
//        } catch {
//            print(error)
//            return []
//        }
//    }

    func fetchMakeYear(make: Int, year: String) {
        let urlMakeYearString = "\(baseURL)GetModelsForMakeIdYear/makeId/\(make)/modelyear/\(year)?format=json"
        performRequest(urlMakeYearString: urlMakeYearString)
    }
    
    func performRequest(urlMakeYearString: String) {
        // 1. Create URL
        print(urlMakeYearString)
        if let url = URL(string: urlMakeYearString) {
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
                    let vehicleInfo = self.parseJSON(vehicleInfo: safeData)
                    delegate?.didReceiveVehicleInfo(vehicleInfo: vehicleInfo)
                }
            }
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(vehicleInfo: Data) -> [VehicleInfo] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MakeYearContainer.self, from: vehicleInfo)
            
            return decodedData.Results
        } catch {
            print(error)
            return []
        }
    }
    
}
