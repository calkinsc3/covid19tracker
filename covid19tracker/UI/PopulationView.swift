//
//  PopulationView.swift
//  covid19tracker
//
//  Created by Bill Calkins on 5/20/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import SwiftUI

struct PopulationView: View {
    var body: some View {
        VStack {
            Text("Population Reference").font(.title)
            
            Text("US Population: \(USTotal.usPopulationFormatted)")
            Divider()
            List(statePopulations) { state in
                Text("\(state.longStateName ?? state.state): \(state.formattedPopulation)")
            }
        }
    }
}

struct PopulationView_Previews: PreviewProvider {
    static var previews: some View {
        PopulationView()
    }
}
