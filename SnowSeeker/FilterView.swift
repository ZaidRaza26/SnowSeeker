//
//  FilterView.swift
//  SnowSeeker
//
//  Created by Zaid Raza on 21/01/2021.
//  Copyright © 2021 Zaid Raza. All rights reserved.
//

import SwiftUI

struct FilterView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var filterString: String
    
    @Binding var resortsCopy: [Resort]
    var resortsOriginal: [Resort]
    
    @State private var resorts: [String] = []
    var body: some View {
        NavigationView {
            VStack{
                if filterString == "country"{
                    List(resorts, id: \.self){ resort in
                        HStack{
                            Image(resort)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 25)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 5)
                            )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.black,lineWidth: 1)
                            )
                            
                            Text(resort)
                        }
                        .onTapGesture {
                            self.resortsCopy = self.resortsCopy.filter{ $0.country.contains(resort)}
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                else if filterString == "size"{
                    VStack{
                        Form{
                            Section{
                                HStack{
                                    Text("Small")
                                }
                                .onTapGesture {
                                    self.resortsCopy = self.resortsCopy.filter{ $0.size == 1}
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }
                            Section{
                                HStack{
                                    Text("Average")
                                }
                                .onTapGesture {
                                    self.resortsCopy = self.resortsCopy.filter{ $0.size == 2}
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }
                            Section{
                                HStack{
                                    Text("Large")
                                }
                                .onTapGesture {
                                    self.resortsCopy = self.resortsCopy.filter{ $0.size == 3}
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarItems(trailing: Button("Cancel"){
                self.presentationMode.wrappedValue.dismiss()
            })
        }
        .onAppear(perform: resortsArrayToSet)
    }
    
    func resortsArrayToSet(){
        if filterString == "country"{
            resortsCopy = resortsOriginal
            for resort in resortsCopy{
                resorts.append(resort.country)
            }
            
            let resortsSet = Set(resorts)
            resorts = Array(resortsSet)
        }
        else if filterString == "size"{
            resortsCopy = resortsOriginal
        }
    }
}
