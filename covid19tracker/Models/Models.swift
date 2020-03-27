//
//  StateNumbers.swift
//  covid19tracker
//
//  Created by William Calkins on 3/27/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import Foundation
import Combine

typealias StateModels = [StateData]

// MARK: - StateDatum
struct StateData: Codable, Identifiable {
    let id = UUID()
    let state: String
    let positive: Int?
    let positiveScore, negativeScore, negativeRegularScore, commercialScore: Int?
    let grade: Grade?
    let score: Int?
    let negative, pending, hospitalized, death: Int?
    let total: Int
    let lastUpdateEt, checkTimeEt: String?
    let dateModified, dateChecked: String?
    let notes: String?
    let totalTestResults: Int
}

enum Grade: String, Codable {
    case a = "A"
    case b = "B"
    case c = "C"
    case d = "D"
}


