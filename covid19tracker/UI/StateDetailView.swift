//
//  StateDetailView.swift
//  covid19tracker
//
//  Created by William Calkins on 3/28/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import SwiftUI
import os

struct StateDetailView: View {
    
    @EnvironmentObject var userData: UserData
    
    @State var givenState: StateData
    
    var stateIndex: Int {
        userData.statesLookup.firstIndex(where: {$0.abbreviation == givenState.state})!
    }
    
    var body: some View {
        VStack {
            Text("Last Update: \(givenState.asOfDate ?? "")")
            Divider()
            
            HStack {
                VStack {
                    Text("Negative: \(givenState.negative ?? 0)")
                    Text("Positive: \(givenState.positive ?? 0)")
                    Text("Total: \(givenState.totalTestResults)")
                }
                Spacer()
                Button(action: {
                    self.userData.statesLookup[self.stateIndex].isFavorite.toggle()
                }) {
                    if self.userData.statesLookup[self.stateIndex].isFavorite {
                        Image(systemName: "star.fill")
                            .imageScale(.medium)
                            .foregroundColor(.yellow)
                    } else {
                        Image(systemName: "star")
                            .imageScale(.medium)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            
            
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
