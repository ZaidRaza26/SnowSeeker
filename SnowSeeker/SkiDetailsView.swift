//
//  SkiDetailsView.swift
//  SnowSeeker
//
//  Created by Zaid Raza on 17/01/2021.
//  Copyright © 2021 Zaid Raza. All rights reserved.
//

import SwiftUI

struct SkiDetailsView: View {
    
    let resort: Resort

    var body: some View {
        Group {
            Text("Elevation: \(resort.elevation)m").layoutPriority(1)
            Spacer().frame(height: 0)
            Text("Snow: \(resort.snowDepth)cm").layoutPriority(1)
        }
    }
}
