//
//  StatePressViewModel.swift
//  covid19tracker
//
//  Created by William Calkins on 3/29/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import os

//MARK:- State Press ViewModel
class StatePressViewModel: ObservableObject {
    
    @Published var statePressResult: PressData = []
    
    private let statePressFether = StateItemsFetcher()
    private var disposable = Set<AnyCancellable>()
    
    init() {
        self.fetchStatePressResults()
    }
    
    private func fetchStatePressResults() {
        
        statePressFether.statePressItems()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
                switch completion {
                case .failure(let stateItemError):
                    switch stateItemError as StatePublishError {
                    case .decoding(let decodingError):
                        os_log("Decoding error in fetchStatePressResults error: %s", log: Log.subscriberLogger, type: .error, decodingError)
                    case .network(let networkingError):
                        os_log("Networking error in fetchStatePressResults error: %s", log: Log.subscriberLogger, type: .error, networkingError)
                    case .apiError(let apiError) :
                        os_log("API error in StateDataFetcher received in subscriber: %s", log: Log.subscriberLogger, type: .error, apiError)
                    }
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] statePressModels in
                guard let self = self else { return }
                self.statePressResult = statePressModels.sorted(by:{$0.datePublished ?? Date() > $1.datePublished ?? Date()})
            })
            .store(in: &disposable)
    }
    
}
