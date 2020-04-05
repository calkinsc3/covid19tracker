//
//  USInfoViewModel.swift
//  covid19tracker
//
//  Created by Bill Calkins on 4/5/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import os

//MARK: US Info ViewModel
class USInfoViewModel: ObservableObject {
    
    @Published var usInfoResult: USTotal?
    
    private let usInfoFetcher = StateItemsFetcher()
    private var disposable = Set<AnyCancellable>()
    
    init() {
        self.fetchUSInfoResults()
    }
    
    private func fetchUSInfoResults() {
        
        usInfoFetcher.usTotalsItems()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
                switch completion {
                case .failure(let usInfoError):
                    switch usInfoError as USTotalsPublishError {
                    case .decoding(let decodingError):
                        os_log("Decoding error in fetchUSInfoResults error: %s", log: Log.subscriberLogger, type: .error, decodingError)
                    case .network(let networkingError):
                        os_log("Networking error in fetchUSInfoResults error: %s", log: Log.subscriberLogger, type: .error, networkingError)
                    case .apiError(let apiError) :
                        os_log("API error in fetchUSInfoResults received in subscriber: %s", log: Log.subscriberLogger, type: .error, apiError)
                    }
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] usInfoModels in
                guard let self = self else { return }
                self.usInfoResult = usInfoModels.first
            })
            .store(in: &disposable)
        
        
        
    }
    
    
    
}
