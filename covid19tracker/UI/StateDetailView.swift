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
    @ObservedObject var statesViewModel = StatesViewModel()
    @State private var showingBarGraph = false
    
    var givenState: StateData
    
    var stateIndex: Int {
        userData.statesLookup.firstIndex(where: {$0.abbreviation == givenState.state})!
    }
    
    var body: some View {
        ZStack {

            //Color("PrimaryBackground").edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Last Update: \(givenState.asOfDate ?? "")")
                Divider()
                
                HStack {
                    
                    VStack {
                        Text("Negative: \(givenState.negative ?? 0)")
                        Text("Positive: \(givenState.positive )")
                        Text("Total: \(givenState.totalTestResults)")
                        
                    }
                }
                Divider()
                Text("Deaths: \(givenState.death )")
                Divider()
                Text("\(givenState.populationTested ?? "") Tested")
                Divider()
                
                List(statesViewModel.stateDailyResults) { dailyResults in
                    StateDailyCell(dailyStateData: dailyResults)
                }
                
                
//                BarGraphView(bindedBarValues: self.$statesViewModel.barGraphValues, bindedBarAverageValues: self.$statesViewModel.barGraphAvgValues)
                
            }
        }
        
        .navigationBarTitle(givenState.stateName ?? "")
        .onAppear {
            self.statesViewModel.fetchStateDailyResults(forState: self.givenState.state)
        }
    }
}

struct StateDailyCell: View {
    
    let dailyStateData : StateDailyDatum
    
    var body: some View {
        
        VStack (alignment: .center) {
            Text("Date: \(dailyStateData.dateCheckedDisplay ?? "Unknown")")
            HStack {
                VStack (alignment: .leading) {
                    Text("Positive")
                        .font(.headline)
                    Text("\(dailyStateData.positive)")
                }
                .font(.subheadline)
                
                VStack (alignment: .leading) {
                    Text("Negative")
                        .font(.headline)
                    Text("\(dailyStateData.negative ?? 0)")
                }
                .font(.subheadline)
            }
            Text(dailyStateData.recovered != nil ? "Recoveries: \(dailyStateData.recovered ?? 0)" : "")
        }
    }
}

struct StateDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StateDetailView(givenState: StateData.placeholder)
            StateDailyCell(dailyStateData: StateDailyDatum.placeholder)
        }
        
    }
}
