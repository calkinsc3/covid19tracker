//
//  StateInfoViewModel.swift
//  covid19tracker
//
//  Created by William Calkins on 3/29/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import os


//StateInfo ViewModel
class StateInfoViewModel: ObservableObject {
    
    @Published var stateInfo : StateInfo = []
    
    private let stateInfoFetcher = StateItemsFetcher()
    private var disposable = Set<AnyCancellable>()
    
    init() {
        self.fetchStateInfoResults()
    }
    
    private func fetchStateInfoResults() {
        
        stateInfoFetcher.stateInfoItems()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
                switch completion {
                case .failure(let stateItemError):
                    switch stateItemError as StatePublishError {
                    case .decoding(let decodingError):
                        os_log("Decoding error in fetchProducts error: %s", log: Log.subscriberLogger, type: .error, decodingError)
                    case .network(let networkingError):
                        os_log("Networking error in fetchProducts error: %s", log: Log.subscriberLogger, type: .error, networkingError)
                    case .apiError(let apiError) :
                        os_log("API error in StateDataFetcher received in subscriber: %s", log: Log.subscriberLogger, type: .error, apiError)
                    }
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] stateModels in
                guard let self = self else { return }
                self.stateInfo = stateModels.sorted(by:{$0.name < $1.name})
            })
            .store(in: &disposable)
        
    }
    
}

