//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Zaid Raza on 17/01/2021.
//  Copyright © 2021 Zaid Raza. All rights reserved.
//

import SwiftUI

struct ResortView: View {
    
    let resort: Resort
    
    @EnvironmentObject var favorites: Favorites
    
    @State private var selectedFacility: Facility?
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 0){
                ZStack(alignment: .bottom){
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    
                    HStack{
                        Text(resort.imageCredit)
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }
                
                Group{
                    HStack {
                        if sizeClass == .compact{
                            Spacer()
                            VStack { ResortDetailsView(resort: resort) }
                            VStack { SkiDetailsView(resort: resort) }
                            Spacer()
                        }
                        else {
                            ResortDetailsView(resort: resort)
                            Spacer().frame(height: 0)
                            SkiDetailsView(resort: resort)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
            
            Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                if self.favorites.contains(self.resort) {
                    self.favorites.remove(self.resort)
                } else {
                    self.favorites.add(self.resort)
                }
            }
            .padding()
        }
        .alert(item: $selectedFacility) { facility in
            facility.alert
        }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
    }
}
