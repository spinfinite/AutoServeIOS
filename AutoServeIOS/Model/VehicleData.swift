//
//  VehicleData.swift
//  AutoServeIOS
//
//  Created by Dad's 6,1 on 9/1/23.
//

import Foundation

struct MakeContainer: Decodable {
    
    let Results: [MakeData]
    
}


struct MakeData: Decodable {
    
    let Make_ID: Int
    let Make_Name: String
    
    
}
