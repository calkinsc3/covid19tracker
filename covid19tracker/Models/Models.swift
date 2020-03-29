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
    let dateModified, dateChecked: Date?
    let notes: String?
    let totalTestResults: Int
    
    var stateName: String? {
        unitedStates[self.state]
    }
    
    var asOfDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        
        return dateFormatter.string(from: self.dateModified ?? Date())
    }
    
    var formattedPositive: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self.positive ?? 0))
    }
    
    var formattedNegative: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self.negative ?? 0))
    }
    
    var forattedDeath: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self.death ?? 0))
    }
    
    static let `placeholder` = Self(state: "WI", positive: 707, positiveScore: 1, negativeScore: 1, negativeRegularScore: 1, commercialScore: 1, grade: .a, score: 4, negative: 11583, pending: nil, hospitalized: nil, death: 8, total: 12290, lastUpdateEt: "3/26 16:00", checkTimeEt: "3/26 15:54", dateModified: Date(), dateChecked: Date(), notes: "Please stop using the \"total\" field. Use \"totalTestResults\" instead.", totalTestResults: 12290)
}

enum Grade: String, Codable {
    case a = "A"
    case b = "B"
    case c = "C"
    case d = "D"
}


