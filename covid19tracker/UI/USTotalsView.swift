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
            Text("US Totals").font(.largeTitle)
            Divider()
            Text("Last Modified: \(usInfoViewModel.usInfoResult?.datePublishedDisplay ?? "today")")
            Divider()
            Text("Positive: \(usInfoViewModel.usInfoResult?.formattedPositive ?? "0")")
            Text("Currently in ICU: \(usInfoViewModel.usInfoResult?.formattedInICU ?? "0")")
            Text("Hospitalized: \(usInfoViewModel.usInfoResult?.formattedHospitalized ?? "0")")
            Divider()
            Text("Deaths: \(usInfoViewModel.usInfoResult?.forattedDeath ?? "0")")
            Divider()
        }
        .font(.title)
    }
}

struct USTotalsView_Previews: PreviewProvider {
    static var previews: some View {
        USTotalsView()
    }
}
