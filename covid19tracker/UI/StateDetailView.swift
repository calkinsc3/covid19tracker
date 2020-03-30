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
    
    @State var givenState: StateData
    
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
                    self.givenState.isFavorite = true
                    os_log("StateDetail isFavorite %d", log: Log.viewLogger, type: .info, self.givenState.isFavorite ?? false)
                }) {
                    if self.givenState.isFavorite ?? false {
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
