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

//MARK:- States ViewModel
class StatesViewModel: ObservableObject {
    
    @Published var stateResults : StateModels = []
    
    private let stateFetcher = StateItemsFetcher()
    private var disposable = Set<AnyCancellable>()
    
    init() {
       // self.fetchStatesResults()
    }
    
    func fetchStatesResults() {
        
        //clear existing data
        //if !self.stateResults.isEmpty { self.stateResults.removeAll() }
        
        stateFetcher.stateItems()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
                switch completion {
                case .failure(let stateItemError):
                    switch stateItemError as StatePublishError {
                    case .decoding(let decodingError):
                        //TODO: implement os_log
                        print("Decoding error in fetchProducts error: \(decodingError)")
                    case .network(let networkingError):
                        print("Networking error in fetchProducts error: \(networkingError)")
                    case .apiError(let apiError) :
                        print("API error occurned: \(apiError)")
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
