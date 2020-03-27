//
//  StateFetcher.swift
//  covid19tracker
//
//  Created by William Calkins on 3/27/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import Foundation
import Combine

typealias StatePublisher = AnyPublisher<StateModels, StatePublishError>

protocol StateFetchable {
    func stateItems() -> StatePublisher
}

//MARK: - StateItemsFetcher
class StateItemsFetcher {
    
    private let session: URLSession
    
    init() {
        self.session = URLSession.shared
    }
    
}

extension StateItemsFetcher : StateFetchable {
    
    func stateItems() -> StatePublisher {
        return self.stateItems(with: self.makeCOVIDStateComponents())
    }
    
    //MARK:- State Publisher
    private func stateItems<T>(with components: URLComponents) -> AnyPublisher<T, StatePublishError> where T: Decodable {
        
        guard let url = components.url else {
            let error = StatePublishError.network(description: "Couldn't create URL for COVID State data")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .mapError { error in
                StatePublishError.network(description: error.localizedDescription)
        }
        .flatMap { pair in
            decode(pair.data)
        }
        .eraseToAnyPublisher()
    }
    
    
}

private extension StateItemsFetcher {
    
    struct COVID19_API {
        static let schema = "https"
        static let host = "covidtracking.com"
        static let path = "/api/states"
    }
    
    func makeCOVIDStateComponents() -> URLComponents {
        
        var components = URLComponents()
        
        components.scheme = COVID19_API.schema
        components.host = COVID19_API.host
        components.path = COVID19_API.path
        
        return components
    }
    
}
