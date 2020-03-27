//
//  ErrorConstants.swift
//  covid19tracker
//
//  Created by William Calkins on 3/27/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import Foundation

enum StatePublishError: Error {
    case network(description: String)
    case decoding(description: String)
    case apiError(description: String)
}
