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
typealias StateInfoPublisher = AnyPublisher<StateInfo, StatePublishError>
typealias StatePressPublisher = AnyPublisher<PressData, StatePublishError>
typealias StateDailyPublisher = AnyPublisher<StateDailyData, StatePublishError>
typealias USTotalsPublisher = AnyPublisher<USTotals, USTotalsPublishError>

protocol StateFetchable {
    func stateItems() -> StatePublisher
    func stateInfoItems() -> StateInfoPublisher
    func statePressItems() -> StatePressPublisher
    func usTotalsItems() -> USTotalsPublisher
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
    
    func stateInfoItems() -> StateInfoPublisher {
        return self.stateItems(with: self.makeCOVIDStateInfoComponents())
    }
    
    func statePressItems() -> StatePressPublisher {
        return self.stateItems(with: self.makeCOVIDPressComponents())
    }
    
    func stateDailyItems(forState state: String) -> StateDailyPublisher {
        return self.stateItems(with: self.makeCOVIDDailyStateInfoComponents(forState: state))
    }
    
    func usTotalsItems() -> USTotalsPublisher {
        return self.usItems(with: self.makeCOVIDUSTotalsComponents())
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
    
    //MARK:- US Totals Publisher
    private func usItems<T>(with components: URLComponents) -> AnyPublisher<T, USTotalsPublishError> where T: Decodable {
        
        guard let url = components.url else {
            let error = USTotalsPublishError.network(description: "Couldn't create URL for COVID US data")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .mapError { error in
                USTotalsPublishError.network(description: error.localizedDescription)
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
        static let infoPath = "/api/urls"
        static let pressPath = "/api/press"
        static let dailyPath = "\(path)/daily"
        static let usTotalsPath = "/api/us"
    }
    
    func makeCOVIDStateComponents() -> URLComponents {
        
        var components = URLComponents()
        
        components.scheme = COVID19_API.schema
        components.host = COVID19_API.host
        components.path = COVID19_API.path
        
        return components
    }
    
    func makeCOVIDStateInfoComponents() -> URLComponents {
        
        var components = URLComponents()
        
        components.scheme = COVID19_API.schema
        components.host = COVID19_API.host
        components.path = COVID19_API.infoPath
        
        return components
    }
    
    func makeCOVIDPressComponents() -> URLComponents {
        
        var components = URLComponents()
        
        components.scheme = COVID19_API.schema
        components.host = COVID19_API.host
        components.path = COVID19_API.pressPath
        
        return components
    }
    
    func makeCOVIDDailyStateInfoComponents(forState state: String) -> URLComponents {
        
        var components = URLComponents()
        
        components.scheme = COVID19_API.schema
        components.host = COVID19_API.host
        components.path = COVID19_API.dailyPath
        components.queryItems = [URLQueryItem(name: "state", value: state)]
        
        return components
    }
    
    func makeCOVIDUSTotalsComponents() -> URLComponents {
        
        var components = URLComponents()
        
        components.scheme = COVID19_API.schema
        components.host = COVID19_API.host
        components.path = COVID19_API.usTotalsPath
        
        return components
    }
    
}
