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
    
    @State var showingSortSheet = false
    
    var sortingActionSheet: ActionSheet {
        ActionSheet(title: Text("Sort By"),
                    message: Text("How would you like to sort the States?"), buttons: [
                        .default(Text("Most Recent"), action: {
                            self.statesViewModel.stateResults = self.statesViewModel.stateResults.sorted(by: {$0.dateModified ?? Date() > $1.dateModified ?? Date()})
                        }),
                        .default(Text("Positive Tests"), action: {
                            self.statesViewModel.stateResults = self.statesViewModel.stateResults.sorted(by: {$0.positive ?? 0 > $1.positive ?? 0})
                        }),
                        .default(Text("Negative Tests"), action: {
                            self.statesViewModel.stateResults = self.statesViewModel.stateResults.sorted(by: {$0.negative ?? 0 > $1.negative ?? 0})
                        }),
                        .default(Text("Total Tested"), action: {
                            self.statesViewModel.stateResults = self.statesViewModel.stateResults.sorted(by: {$0.totalTestResults > $1.totalTestResults})
                        }),
                        .default(Text("Deaths"), action: {
                            self.statesViewModel.stateResults = self.statesViewModel.stateResults.sorted(by: {$0.death ?? 0 > $1.death ?? 0})
                        }),
                        .cancel(Text("Cancel"))
        ])
    }
    
    var sortActionSheetButton: some View {
        Button(action: {
            self.showingSortSheet.toggle()
        }) {
            Image(systemName: "arrow.up.arrow.down.square").font(.title)
        }
    }
    
    var body: some View {
        NavigationView {
            List(self.statesViewModel.stateResults) { state in
                NavigationLink(destination: StateDetailView(givenState: state)) {
                    StateCellView(state: state)
                }
            }
            .navigationBarTitle("States")
            .navigationBarItems(trailing: self.sortActionSheetButton)
            .actionSheet(isPresented: $showingSortSheet) {
                self.sortingActionSheet
            }
        }
    }
}

struct StateCellView: View {
    
    let state: StateData
    
    var body: some View {
        VStack {
            Text(state.stateName ?? "")
                .font(.title)
            Text("Updated: \(state.asOfDate ?? "")")
                .font(.body)
            HStack {
                Text("Positive: \(String(state.formattedPositive ?? "0"))")
                    .font(.body)
                
                Text("Deaths: \(String(state.forattedDeath ?? "0"))")
                    .font(.body)
            }
        }
    }
}

struct StatesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatesView()
            StateCellView(state: StateData.placeholder)
        }
        
    }
}