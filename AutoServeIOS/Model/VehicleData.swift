//
//  VehicleData.swift
//  AutoServeIOS
//
//  Created by Dad's 6,1 on 9/1/23.
//

import Foundation

struct MakeContainer: Codable {
    let Results: [MakeData]
    
}

struct MakeData: Codable {
    let Make_ID: Int
    let Make_Name: String

}

struct ModelContainer: Codable {
    let Results: [ModelData]
}

struct ModelData: Codable {
    let Make_ID: Int
    let Model_Name: String
}

struct MakeYearContainer: Codable {
    let Results: [VehicleInfo]
}

struct VehicleInfo: Codable {
    let Make_ID: Int
    let Make_Name: String
    let Model_Name: String
}
