//
//  Parsing.swift
//  covid19tracker
//
//  Created by William Calkins on 3/27/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import Foundation
import Combine

//MARK:- State Item
func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, StatePublishError> {
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            .decoding(description: (error as? DecodingError).debugDescription)
    }
    .eraseToAnyPublisher()
}

//MARK:- US Items
func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, USTotalsPublishError> {
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            .decoding(description: (error as? DecodingError).debugDescription)
    }
    .eraseToAnyPublisher()
}
