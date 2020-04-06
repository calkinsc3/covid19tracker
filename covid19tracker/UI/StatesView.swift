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
    
    @State var showingSortSheet = false
    @State var showingUSTotals = false
    
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
    
    var usTotalsSheetButton: some View {
        Button(action: {
            self.showingUSTotals.toggle()
        }) {
            Image(systemName: "sum")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Divider()
                Toggle(isOn: $userData.showWatchedOnly) {
                    Text("Watched")
                }
                .padding()
                
                List(self.statesViewModel.stateResults) { state in
                    //FIXME:- find a better way
                    if !self.userData.showWatchedOnly || self.userData.statesLookup[self.userData.statesLookup.firstIndex(where: {$0.abbreviation == state.state})!].isFavorite  {
                        NavigationLink(destination: StateDetailView(givenState: state)) {
                            StateCellView(state: state).environmentObject(self.userData)
                        }
                    }
                }
            }
            .navigationBarTitle("States")
            .navigationBarItems(leading: self.usTotalsSheetButton, trailing: self.sortActionSheetButton)
            .actionSheet(isPresented: $showingSortSheet) {
                self.sortingActionSheet
            }
            .sheet(isPresented: $showingUSTotals, content: {
                USTotalsView()
            })
            
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
            if userData.statesLookup.filter({$0.abbreviation == state.state}).first?.isFavorite ?? false {
                Image(systemName: "star.fill")
                    .imageScale(.medium)
                    .foregroundColor(.yellow)
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
