//
//  USTotalsView.swift
//  covid19tracker
//
//  Created by William Calkins on 4/5/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import SwiftUI



struct USTotalsView: View {
    
    @ObservedObject var usInfoViewModel = USInfoViewModel()
    
    var body: some View {
        VStack {
            Text("Last Modified: \(usInfoViewModel.usInfoResult?.lastModified ?? "today")")
            Text("Positive: \(usInfoViewModel.usInfoResult?.formattedPositive ?? "0")")
            Text("Currently in ICU: \(usInfoViewModel.usInfoResult?.formattedInICU ?? "0")")
            Text("Hospitalized: \(usInfoViewModel.usInfoResult?.formattedHospitalized ?? "0")")
            Divider()
            Text("Deaths: \(usInfoViewModel.usInfoResult?.forattedDeath ?? "0")")
        }
    }
}

struct USTotalsView_Previews: PreviewProvider {
    static var previews: some View {
        USTotalsView()
    }
}
