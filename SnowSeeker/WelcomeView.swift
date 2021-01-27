//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Zaid Raza on 17/01/2021.
//  Copyright © 2021 Zaid Raza. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)
            
            Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
                .foregroundColor(.secondary)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
