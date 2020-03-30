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
    @Published var showFavoritesOnly = false
    
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
    
    
}
