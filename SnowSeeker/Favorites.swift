//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Zaid Raza on 20/01/2021.
//  Copyright © 2021 Zaid Raza. All rights reserved.
//

import SwiftUI

class Favorites: ObservableObject {
    
    private var resorts: Set<String>
    
    private let saveKey = "Favorites"
    
    init() {
        if let items = UserDefaults.standard.data(forKey: saveKey) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(Set<String>.self, from: items) {
                self.resorts = decoded
                print(self.resorts)
                return
            }
        }
        self.resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self.resorts){
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
}
