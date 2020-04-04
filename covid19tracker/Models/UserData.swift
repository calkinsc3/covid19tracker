//
//  UserData.swift
//  covid19tracker
//
//  Created by William Calkins on 3/30/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject {
    @Published var showWatchedOnly = false
    @Published var statesLookup = stateLookupData
}
