//
//  Resort.swift
//  SnowSeeker
//
//  Created by Zaid Raza on 16/01/2021.
//  Copyright © 2021 Zaid Raza. All rights reserved.
//

import Foundation

struct Resort: Codable, Identifiable, Hashable {
    
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
}
