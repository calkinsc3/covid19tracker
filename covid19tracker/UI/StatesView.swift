//
//  StatesView.swift
//  covid19tracker
//
//  Created by William Calkins on 3/27/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import SwiftUI

struct StatesView: View {
    
    @EnvironmentObject var userData: UserData
    
    @ObservedObject var statesViewModel = StatesViewModel()
    @ObservedObject var usInfoViewModel = USInfoViewModel()
    
    @State private var showingSortSheet = false
    @State private var showingUSTotals = false
    @State private var showWatchedOnly = false
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .center) {
                Divider()
                
                List(self.statesViewModel.stateResults) { state in
                    NavigationLink(destination: StateDetailView(givenState: state)) {
                        StateCellView(state: state).environmentObject(self.userData)
                    }
                }
            }
            .navigationBarTitle("States")
            .navigationBarItems(leading: self.usTotalsSheetButton, trailing: self.sortActionSheetButton)
            .actionSheet(isPresented: $showingSortSheet) {
                self.sortingActionSheet
            }
            .sheet(isPresented: $showingUSTotals, content: {
                USTotalsView (onDismiss: ({
                    self.showingUSTotals = false
                }))
            })
        }
    }
}

private extension StatesView {
    
    var sortingActionSheet: ActionSheet {
        ActionSheet(title: Text("Sort By"),
                    message: Text("How would you like to sort the States?"), buttons: [
                        .default(Text("Most Recent"), action: {
                            self.statesViewModel.stateResults = self.statesViewModel.stateResults.sorted(by: {$0.dateModified ?? Date() > $1.dateModified ?? Date()})
                        }),
                        .default(Text("Positive Tests"), action: {
                            self.statesViewModel.stateResults = self.statesViewModel.stateResults.sorted(by: {$0.positive ?? 0 > $1.positive ?? 0})
                        }),
                        .default(Text("Deaths"), action: {
                            self.statesViewModel.stateResults = self.statesViewModel.stateResults.sorted(by: {$0.death ?? 0 > $1.death ?? 0})
                        }),
                        .default(Text("Alphabetically Asc"), action: {
                            self.statesViewModel.stateResults = self.statesViewModel.stateResults.sorted(by: {$0.stateName ?? "" < $1.stateName ?? ""})
                        }),
                        .default(Text("Alphabetically Desc"), action: {
                            self.statesViewModel.stateResults = self.statesViewModel.stateResults.sorted(by: {$0.stateName ?? "" > $1.stateName ?? ""})
                        }),
                        .default(Text("Most Tested"), action: {
                            self.statesViewModel.stateResults = self.statesViewModel.stateResults.sorted(by: {$0.populationTestedVal ?? 0 > $1.populationTestedVal ?? 0})
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
    
    var usTotalsSheetButton: some View {
        Button(action: {
            self.showingUSTotals.toggle()
        }) {
            Text("US Totals").font(.body)
        }
    }
    
}

struct StateCellView: View {
    
    @EnvironmentObject var userData: UserData
    
    let state: StateData
    @State private var favorite = false
    
    var body: some View {
        
        HStack {
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
            .listRowBackground(Color("PrimaryBackground"))
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
