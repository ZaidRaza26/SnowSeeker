//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Zaid Raza on 16/01/2021.
//  Copyright © 2021 Zaid Raza. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    enum ActionSheetCase {
        case sort, filter
    }
    
    @State var resort: [Resort] = Bundle.main.decode("resorts.json")
    @State var resortCopy: [Resort] = []
    
    @ObservedObject var favorites = Favorites()
    
    @State private var actionSheetIsDisplaying = false
    @State private var sheetIsDisplaying = false
    
    @State private var actionSheetCase : ActionSheetCase = .sort
    
    @State var filterString = ""
    
    var body: some View {
        
        NavigationView{
            List(resortCopy){ resort in
                NavigationLink(destination: ResortView(resort: resort)){
                    Image(resort.country)
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
                    
                    VStack(alignment: .leading){
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(leading: Button("Sort"){
                self.actionSheetIsDisplaying = true
                self.actionSheetCase = .sort
                }, trailing: Button("Filter"){
                    self.actionSheetIsDisplaying = true
                    self.actionSheetCase = .filter
            })
            WelcomeView()
        }
        .sheet(isPresented: $sheetIsDisplaying){
            FilterView(filterString: self.filterString, resortsCopy: self.$resortCopy, resortsOriginal: self.resort)
        }
        .environmentObject(favorites)
        .onAppear{
            self.resortCopy = self.resort
        }
        .actionSheet(isPresented: $actionSheetIsDisplaying){
            
            switch actionSheetCase{
            case .sort:
                return ActionSheet(title: Text("Select Sorting Options"), buttons: [
                    .default(Text("Alphabetically")) { self.resortCopy.sort{ $0.name < $1.name } },
                    .default(Text("Country")) { self.resortCopy.sort{ $0.country < $1.country } },
                    .cancel()
                ])
            case .filter:
                return ActionSheet(title: Text("Select Filtering Options"), buttons: [
                    .default(Text("Country")) { self.sheetIsDisplaying = true
                        self.filterString = "country"
                    },
                    .default(Text("Size")) { self.sheetIsDisplaying = true
                        self.filterString = "size"
                    },
                    .cancel()
                ])
            }
        }
    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}
