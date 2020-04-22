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
    @Published var barGraphValues: [[CGFloat]] = [
        [121.0,153.0,147.0,154.0,170.0,154.0,166.0,127.0,87.0],
        [41.0,21.0,14.0,23.0,32.0, 30.0,42.0,56.0,19.0],
        [12.0,10.0,9.0,6.0,8.0,15.0,12.0,16.0,10.0]]
    
    private let stateFetcher = StateItemsFetcher()
    private var disposable = Set<AnyCancellable>()
    
    init() {
        self.fetchStatesResults()
    }
    
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
                let positiveIncrease = Array(sortedDailyModels.compactMap({$0.positiveIncrease}).map({CGFloat($0)}).prefix(9))
                let hospitalIncrease = Array(sortedDailyModels.compactMap({$0.hospitalizedIncrease}).map({CGFloat($0)}).prefix(9))
                let deathIncreases = Array(sortedDailyModels.compactMap({$0.deathIncrease}).map({CGFloat($0)}).prefix(9))
                
                self.barGraphValues = [positiveIncrease, hospitalIncrease, deathIncreases]
                
            })
            .store(in: &disposable)
    }
}
