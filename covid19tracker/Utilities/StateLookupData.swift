//
//  Constants.swift
//  covid19tracker
//
//  Created by William Calkins on 3/28/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import Foundation


let stateLookupData: [USState] = loadStates()

struct USState {
    let abbreviation : String
    let longName : String
    let isFavorite = false
    
}

let unitedStates = [
    "AL": "Alabama",
    "AK": "Alaska",
    "AS": "American Samoa",
    "AZ": "Arizona",
    "AR": "Arkansas",
    "CA": "California",
    "CO": "Colorado",
    "CT": "Connecticut",
    "DE": "Delaware",
    "DC": "District Of Columbia",
    "FM": "Federated States Of Micronesia",
    "FL": "Florida",
    "GA": "Georgia",
    "GU": "Guam",
    "HI": "Hawaii",
    "ID": "Idaho",
    "IL": "Illinois",
    "IN": "Indiana",
    "IA": "Iowa",
    "KS": "Kansas",
    "KT": "Kentucky",
    "LA": "Louisiana",
    "ME": "Maine",
    "MH": "Marshall Islands",
    "MD": "Maryland",
    "MA": "Massachusetts",
    "MI": "Michigan",
    "MN": "Minnesota",
    "MS": "Mississippi",
    "MO": "Missouri",
    "MT": "Montana",
    "NE": "Nebraska",
    "NV": "Nevada",
    "NH": "New Hampshire",
    "NJ": "New Jersey",
    "NM": "New Mexico",
    "NY": "New York",
    "NC": "North Carolina",
    "ND": "North Dakota",
    "MP": "Northern Mariana Islands",
    "OH": "Ohio",
    "OK": "Oklahoma",
    "OR": "Oregon",
    "PW": "Palau",
    "PA": "Pennsylvania",
    "PR": "Puerto Rico",
    "RI": "Rhode Island",
    "SC": "South Carolina",
    "SD": "South Dakota",
    "TN": "Tennessee",
    "TX": "Texas",
    "UT": "Utah",
    "VT": "Vermont",
    "VI": "Virgin Islands",
    "VA": "Virginia",
    "WA": "Washington",
    "WV": "West Virginia",
    "WI": "Wisconsin",
    "WY": "Wyoming"
]

func loadStates() -> [USState] {
    return unitedStates.map{USState(abbreviation: $0.key, longName: $0.value)}
}


struct StatePopulation: Identifiable, Hashable, Equatable, Codable {
    let id = UUID()
    
    //var id = UUID()
    let state: String
    let population: Double
    
    var formattedPopulation: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self.population)) ?? ""
    }
    
    var longStateName: String? {
        return unitedStates[self.state]
    }
}
//Derived: https://en.wikipedia.org/wiki/List_of_states_and_territories_of_the_United_States_by_population
let statePopulations = [
    StatePopulation(state: "AL", population: 4903185),
    StatePopulation(state: "AK", population: 731545),
    StatePopulation(state: "AZ", population: 7278717),
    StatePopulation(state: "AR", population: 3017825),
    StatePopulation(state: "CA", population: 39512223),
    StatePopulation(state: "CO", population: 5758736),
    StatePopulation(state: "CT", population: 3565287),
    StatePopulation(state: "DE", population: 973764),
    StatePopulation(state: "DC", population: 705749),
    StatePopulation(state: "FL", population: 21477737),
    StatePopulation(state: "GA", population: 10617423),
    StatePopulation(state: "HI", population: 1415872),
    StatePopulation(state: "ID", population: 1787065),
    StatePopulation(state: "IL", population: 12671821),
    StatePopulation(state: "IN", population: 6732219),
    StatePopulation(state: "IA", population: 3155070),
    StatePopulation(state: "AR", population: 3017825),
    StatePopulation(state: "KS", population: 2913314),
    StatePopulation(state: "KT", population: 4467673),
    StatePopulation(state: "LA", population: 4648794),
    StatePopulation(state: "ME", population: 1344212),
    StatePopulation(state: "MD", population: 6045680),
    StatePopulation(state: "MI", population: 9986857),
    StatePopulation(state: "MA", population: 6949503),
    StatePopulation(state: "MN", population: 5639632),
    StatePopulation(state: "MI", population: 2976149),
    StatePopulation(state: "MO", population: 6137428),
    StatePopulation(state: "MT", population: 1068778),
    StatePopulation(state: "NE", population: 1934408),
    StatePopulation(state: "NV", population: 3080156),
    StatePopulation(state: "NH", population: 1359711),
    StatePopulation(state: "NJ", population: 8882190),
    StatePopulation(state: "NM", population: 2096829),
    StatePopulation(state: "NY", population: 19453561),
    StatePopulation(state: "NC", population: 10488084),
    StatePopulation(state: "ND", population: 762062),
    StatePopulation(state: "OH", population: 11689100),
    StatePopulation(state: "OK", population: 3956971),
    StatePopulation(state: "OR", population: 4217737),
    StatePopulation(state: "PA", population: 12801989),
    StatePopulation(state: "RI", population: 1059361),
    StatePopulation(state: "SC", population: 5148714),
    StatePopulation(state: "SD", population: 884659),
    StatePopulation(state: "TN", population: 6833174),
    StatePopulation(state: "TX", population: 28995881),
    StatePopulation(state: "UT", population: 3205958),
    StatePopulation(state: "VT", population: 623989),
    StatePopulation(state: "VA", population: 8535519),
    StatePopulation(state: "WA", population: 7614893),
    StatePopulation(state: "WV", population: 1792147),
    StatePopulation(state: "WI", population: 5822434),
    StatePopulation(state: "WY", population: 578759)
]

class StatePopulations: ObservableObject {
    @Published var givenStatePopulations = statePopulations
}
