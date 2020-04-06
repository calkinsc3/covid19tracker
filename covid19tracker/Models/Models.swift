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
    var isFavorite : Bool? = false
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

enum Language: String, Codable {
    case en = "EN"
    case es = "ES"
    case fr = "FR"
    case it = "IT"
    case pt = "PT"
}

enum UsesCovidTrackingData: String, Codable {
    case no = "no"
    case usesCovidTrackingDataYes = "Yes"
    case yes = "yes"
}

// MARK: - StateDailyDatum
struct StateDailyDatum: Codable, Identifiable {
    let id = UUID()
    let date: Int
    let state: String
    let positive : Int
    let negative: Int?
    let pending, hospitalizedCurrently, hospitalizedCumulative, inIcuCurrently: Int?
    let inIcuCumulative: Int?
    let onVentilatorCurrently, onVentilatorCumulative: Int?
    let recovered: Int?
    let hash: String
    let dateChecked: Date
    let death: Int?
    let hospitalized: Int?
    let total, totalTestResults, posNeg: Int
    let fips: String
    let deathIncrease, hospitalizedIncrease, negativeIncrease, positiveIncrease: Int?
    let totalTestResultsIncrease: Int?
    
    var dateCheckedDisplay: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        
        return dateFormatter.string(from: self.dateChecked)
    }
    
    static let `placeholder` = Self(date: 20200402, state: "NY", positive: 92381, negative: 146584, pending: nil, hospitalizedCurrently: 13383, hospitalizedCumulative: 20817, inIcuCurrently: 3396, inIcuCumulative: nil, onVentilatorCurrently: nil, onVentilatorCumulative: nil, recovered: 7434, hash: "764d0566c27be04c416c502640d5fffbcb8cad26", dateChecked: ISO8601DateFormatter().date(from: "2020-04-02T20:00:00Z") ?? Date(), death: 2373, hospitalized: 20817, total: 238965, totalTestResults: 238965, posNeg: 238965, fips: "fips", deathIncrease: 432, hospitalizedIncrease: 2449, negativeIncrease: 9416, positiveIncrease: 8669, totalTestResultsIncrease: 18085)
}

typealias StateDailyData = [StateDailyDatum]


// MARK: - StateInfoElement
typealias StateInfo = [StateInfoElement]

struct StateInfoElement: Codable, Identifiable {
    let id = UUID()
    let kind: String
    let name: String
    let url: String
    let stateId, filter: String?
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: self.url) else {
            return nil
        }
        return URLRequest(url: url)
    }
    
    static let `placeholder` = Self(kind: "url", name: "Ohio", url: "https://coronavirus.ohio.gov/wps/portal/gov/covid-19/", stateId: "OH", filter: nil)
}

//MARK:- Press
typealias PressData = [PressDatum]

struct PressDatum: Codable, Identifiable {
    let id = UUID()
    let title: String
    let url: String
    let addToCovidTrackingProjectWebsite, featureOnCovidTrackingProjectHomepage, aboutCovidTrackingProject: Bool?
    let publishDate: String
    let continuallyUpdated: Bool?
    let publication: String?
    let author: String?
    let doesThisSourceHaveADataVisualization: Bool?
    let dataSource: String?
    let usesCovidTrackingData: UsesCovidTrackingData?
    let linkToVizImage: String?
    let twitterCopy: String?
    let language: Language?
    
    var datePublished: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        
        return dateFormatter.date(from: self.publishDate)
    }
    
    var datePublishedDisplay: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        
        return dateFormatter.string(from: self.datePublished ?? Date())
    }
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: self.url) else {
            return nil
        }
        return URLRequest(url: url)
    }
}

typealias USTotals = [USTotal]

struct USTotal: Codable {
    let positive, negative, pending, hospitalizedCurrently: Int
    let hospitalizedCumulative, inIcuCurrently, inIcuCumulative, onVentilatorCurrently: Int
    let onVentilatorCumulative, recovered: Int
    let hash, lastModified: String
    let death, hospitalized, total, totalTestResults: Int
    let posNeg: Int
    let notes: String
    
    var formattedPositive: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self.positive))
    }
    
    var formattedInICU: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self.inIcuCurrently))
    }
    
    var formattedHospitalized: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self.hospitalizedCurrently))
    }
    
    var forattedDeath: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self.death))
    }
    
    var datePublished: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        
        return dateFormatter.date(from: self.lastModified)
    }
    
    var datePublishedDisplay: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        
        return dateFormatter.string(from: self.datePublished ?? Date())
    }
}
