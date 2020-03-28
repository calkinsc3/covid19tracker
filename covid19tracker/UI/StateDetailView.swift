//
//  StateDetailView.swift
//  covid19tracker
//
//  Created by William Calkins on 3/28/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import SwiftUI

struct StateDetailView: View {
    
    @State var givenState: StateData
    
    var body: some View {
        VStack {
            Text("Last Update: \(givenState.asOfDate ?? "")")
            Divider()
            Text("Negative: \(givenState.negative ?? 0)")
            Text("Positive: \(givenState.positive ?? 0)")
            Text("Total: \(givenState.totalTestResults)")
            Divider()
            Text("Deaths: \(givenState.death ?? 0)")
            Spacer()
        }
        .navigationBarTitle(givenState.stateName ?? "")
    }
}

struct StateDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StateDetailView(givenState: StateData.placeholder)
    }
}
