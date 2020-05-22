//
//  PopulationView.swift
//  covid19tracker
//
//  Created by Bill Calkins on 5/20/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import SwiftUI
import os

struct PopulationView: View {
    
    @ObservedObject var statePopulatioModel = StatePopulations()
    
    @State private var showingSortSheet = false
    
    var body: some View {
        VStack {
            Text("US Population: \(USTotal.usPopulationFormatted)")
            Divider()
            List(statePopulations) { state in
                Text("\(state.longStateName ?? state.state): \(state.formattedPopulation)")
            }
        }
        .navigationBarTitle("Populations")
        .navigationBarItems(trailing: self.sortPopulationActionSheetButton)
        .actionSheet(isPresented: $showingSortSheet) {
            self.sortingActionSheet
        }
    }
}

private extension PopulationView {
    
    var sortingActionSheet: ActionSheet {
        
        ActionSheet(title: Text("Sort Population By"), message: Text("How would you like to sort the population data?"), buttons: [
            .default(Text("Largest Population"), action: {
                self.statePopulatioModel.givenStatePopulations = self.statePopulatioModel.givenStatePopulations.sorted(by: {$0.population > $1.population})
            }),
            .default(Text("Smallest Population"), action: {
                self.statePopulatioModel.givenStatePopulations = self.statePopulatioModel.givenStatePopulations.sorted(by: {$0.population < $1.population})
            }),
            .default(Text("Alphabetically Desc"), action: {
                self.statePopulatioModel.givenStatePopulations = self.statePopulatioModel.givenStatePopulations.sorted(by: {$0.longStateName ?? "" > $1.longStateName ?? ""})
            }),
            .default(Text("Alphabetically Asc"), action: {
                self.statePopulatioModel.givenStatePopulations = self.statePopulatioModel.givenStatePopulations.sorted(by: {$0.longStateName ?? "" > $1.longStateName ?? ""})
            }),
            .cancel(Text("Cancel"))
        ])
    }
    
    var sortPopulationActionSheetButton: some View {
        Button(action: {
            self.showingSortSheet.toggle()
            os_log("In the sortPopulationActionSheetButton action", log: Log.viewLogger, type: .info)
        }) {
            Image(systemName: "arrow.up.arrow.down.square")
                .font(.title)
        }
    }
    
}

struct PopulationView_Previews: PreviewProvider {
    static var previews: some View {
        PopulationView()
    }
}
