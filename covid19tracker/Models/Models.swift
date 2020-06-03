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
    let isFavorite = false
    let date: Int
    let state: String
    let positive: Int
    let negative, pending, hospitalizedCurrently, hospitalizedCumulative: Int?
    let inIcuCurrently, inIcuCumulative, onVentilatorCurrently, onVentilatorCumulative: Int?
    let recovered: Int?
    let dataQualityGrade: String
    let lastUpdateEt: String
    let dateModified: Date
    let checkTimeEt: String
    let death: Int
    let hospitalized: Int?
    let dateChecked: Date?
    let fips: String
    let positiveIncrease, negativeIncrease, total, totalTestResults: Int
    let totalTestResultsIncrease, posNeg, deathIncrease, hospitalizedIncrease: Int
    let hash: String
    let commercialScore, negativeRegularScore, negativeScore, positiveScore: Int
    let score: Int
    let grade: String?
    
    var stateName: String? {
        unitedStates[self.state]
    }
    
    var asOfDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        
        return dateFormatter.string(from: self.dateModified)
    }
    
    var formattedPositive: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self.positive))
    }
    
    var formattedNegative: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self.negative ?? 0))
    }
    
    var forattedDeath: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self.death))
    }
    
    var populationTestedVal: Double? {
        
        guard let statePopulation = statePopulations.filter({$0.state == self.state}).first else {
            return nil
        }
        
        return Double(self.totalTestResults) / statePopulation.population
        
    }
    
    var populationTested: String? {
        
        let percentageFormatter = NumberFormatter()
        percentageFormatter.numberStyle = .percent
        percentageFormatter.minimumIntegerDigits = 1
        percentageFormatter.maximumIntegerDigits = 4
        percentageFormatter.maximumFractionDigits = 2
        
        if let statePopulation = statePopulations.filter({$0.state == self.state}).first?.population {
            return percentageFormatter.string(from: NSNumber(value: (Double(self.totalTestResults) / statePopulation)))
        } else {
            return nil
        }
        
        
    }
    
    static let `placeholder` = Self(date: 20200601, state: "WI", positive: 18543, negative: 253595, pending: 211, hospitalizedCurrently: 613, hospitalizedCumulative: 2603, inIcuCurrently: 136, inIcuCumulative: 586, onVentilatorCurrently: nil, onVentilatorCumulative: nil, recovered: 11838, dataQualityGrade: "A+", lastUpdateEt: "6/1/2020 00:00", dateModified: Date(), checkTimeEt: "05/31 20:00", death: 595, hospitalized: 2603, dateChecked: Date(), fips: "55", positiveIncrease: 140, negativeIncrease: 3492, total: 272349, totalTestResults: 272138, totalTestResultsIncrease: 3632, posNeg: 272138, deathIncrease: 3, hospitalizedIncrease: 20, hash: "5138400d8446c6a41b0dc0c61bd0d7153b954c00", commercialScore: 0, negativeRegularScore: 0, negativeScore: 0, positiveScore: 0, score: 0, grade: nil)
}

enum Grade: String, Codable {
    case a = "A+"
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
    let dateChecked: Date?
    let death: Int?
    let hospitalized: Int?
    let total, totalTestResults, posNeg: Int
    let fips: String
    let deathIncrease, hospitalizedIncrease, negativeIncrease, positiveIncrease: Int?
    let totalTestResultsIncrease: Int?
    
    var dateCheckedDisplay: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        
        return dateFormatter.string(from: self.dateChecked ?? Date())
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
        return URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
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
    static let usPopulation: Double = 329_641_438
    let positive, negative, pending, hospitalizedCurrently: Int
    let hospitalizedCumulative, inIcuCurrently, inIcuCumulative, onVentilatorCurrently: Int
    let onVentilatorCumulative, recovered: Int
    let hash, lastModified: String
    let death, hospitalized, total, totalTestResults: Int
    let posNeg: Int
    //let grade: String
    
    static var usPopulationFormatted: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: USTotal.usPopulation)) ?? ""
    }
    
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
    
    var formattedUSPopulation: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: USTotal.usPopulation))
    }
    
    var formattedTotalTestResults: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self.totalTestResults))
    }
    
    var totalUSPercentage: String? {
        let percentageFormatter = NumberFormatter()
        percentageFormatter.numberStyle = .percent
        percentageFormatter.minimumIntegerDigits = 1
        percentageFormatter.maximumIntegerDigits = 4
        percentageFormatter.maximumFractionDigits = 2
        
        let percentageTested = (Double(self.totalTestResults) / USTotal.usPopulation)
        
        return percentageFormatter.string(from: NSNumber(value: percentageTested))
    }
    
    var totalUSPositivePercentage: String? {
        let percentageFormatter = NumberFormatter()
        percentageFormatter.numberStyle = .percent
        percentageFormatter.minimumIntegerDigits = 1
        percentageFormatter.maximumIntegerDigits = 4
        percentageFormatter.maximumFractionDigits = 2
        
        let percentagePositive = (Double(self.positive) / USTotal.usPopulation)
        
        return percentageFormatter.string(from: NSNumber(value: percentagePositive))
        
    }
}
