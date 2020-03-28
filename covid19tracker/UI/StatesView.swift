//
//  StatesView.swift
//  covid19tracker
//
//  Created by William Calkins on 3/27/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import SwiftUI

struct StatesView: View {
    
    @ObservedObject var statesViewModel = StatesViewModel()
    
    var body: some View {
        NavigationView {
            List(self.statesViewModel.stateResults) { state in
                NavigationLink(destination: StateDetailView(givenState: state)) {
                    StateCellView(state: state)
                }
            }
            .navigationBarTitle("States")
        }
        .onAppear {
            self.statesViewModel.fetchStatesResults()
        }
    }
}

struct StateCellView: View {
    
    let state: StateData
    
    var body: some View {
        VStack {
            Text(state.stateName ?? "")
                .font(.title)
            Spacer()
            HStack {
                Text("Positive: \(String(state.positive ?? 0))")
                    .font(.body)
                Spacer()
                Text("Deaths: \(String(state.death ?? 0))")
                    .font(.body)
            }
        }
    }
}

struct StatesView_Previews: PreviewProvider {
    static var previews: some View {
        StatesView()
    }
}
