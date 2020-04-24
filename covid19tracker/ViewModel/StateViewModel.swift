//
//  StateViewModel.swift
//  covid19tracker
//
//  Created by William Calkins on 3/27/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import os

//MARK:- States ViewModel
class StatesViewModel: ObservableObject {
    
    @Published var stateResults : StateModels = []
    @Published var stateDailyResults: StateDailyData = []
    @Published var watchStateResults: StateModels = []
    @Published var barGraphValues: [[CGFloat]] = [[]]
    @Published var barGraphAvgValues: [CGFloat] = []
    
    private let stateFetcher = StateItemsFetcher()
    private var disposable = Set<AnyCancellable>()
    
    private let barGraphDataSize = 9
    
    init() {
        self.fetchStatesResults()
    }
    
    //MARK:- State Results
    private func fetchStatesResults() {
        
        stateFetcher.stateItems()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
                switch completion {
                case .failure(let stateItemError):
                    switch stateItemError as StatePublishError {
                    case .decoding(let decodingError):
                        os_log("Decoding error in fetchStatesResults error: %s", log: Log.subscriberLogger, type: .error, decodingError)
                    case .network(let networkingError):
                        os_log("Networking error in fetchStatesResults error: %s", log: Log.subscriberLogger, type: .error, networkingError)
                    case .apiError(let apiError) :
                        os_log("API error in StateDataFetcher received in subscriber: %s", log: Log.subscriberLogger, type: .error, apiError)
                    }
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] stateModels in
                guard let self = self else { return }
                self.stateResults = stateModels.sorted(by:{$0.positive ?? 0 > $1.positive ?? 0})
            })
            .store(in: &disposable)
        
    }
    
    //MARK:- Daily Results
    func fetchStateDailyResults(forState state: String) {
        
        stateFetcher.stateDailyItems(forState: state)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
                switch completion {
                case .failure(let stateItemError):
                    switch stateItemError as StatePublishError {
                    case .decoding(let decodingError):
                        os_log("Decoding error in fetchStateDailyResults error: %s", log: Log.subscriberLogger, type: .error, decodingError)
                    case .network(let networkingError):
                        os_log("Networking error in fetchStateDailyResults error: %s", log: Log.subscriberLogger, type: .error, networkingError)
                    case .apiError(let apiError) :
                        os_log("API error in fetchStateDailyResults received in subscriber: %s", log: Log.subscriberLogger, type: .error, apiError)
                    }
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] stateDailyModels in
                guard let self = self else { return }
                let sortedDailyModels = stateDailyModels.sorted(by:{$0.dateChecked > $1.dateChecked})
                self.stateDailyResults = sortedDailyModels
                
                //gather number for graph results
                let positiveIncrease = Array(sortedDailyModels.compactMap({$0.positiveIncrease}).map({CGFloat($0)}).prefix(self.barGraphDataSize))
                let hospitalIncrease = Array(sortedDailyModels.compactMap({$0.hospitalizedIncrease}).map({CGFloat($0)}).prefix(self.barGraphDataSize))
                let deathIncreases = Array(sortedDailyModels.compactMap({$0.deathIncrease}).map({CGFloat($0)}).prefix(self.barGraphDataSize))
                
                //average value to get the height of the bar graph
                let postiveBarAverage = positiveIncrease.reduce(0.0) {$0 + $1/CGFloat(self.barGraphDataSize)}
                let hospitalBarAverage = hospitalIncrease.reduce((0.0), {$0 + $1/CGFloat(self.barGraphDataSize)})
                let deathBarAverage = deathIncreases.reduce((0.0), {$0 + $1/CGFloat(self.barGraphDataSize)})
                
                self.barGraphValues = [positiveIncrease, hospitalIncrease, deathIncreases]
                self.barGraphAvgValues = [postiveBarAverage, hospitalBarAverage, deathBarAverage]
                
            })
            .store(in: &disposable)
    }
}
