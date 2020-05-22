//
//  AboutView.swift
//  covid19tracker
//
//  Created by William Calkins on 4/19/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    @State private var showingCOVIDProject = false
    @State private var showingStatePopulations = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                Image("COVIDIcon")
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)
                
                
                NavigationLink(destination: StateWebController(urlRequest: URLRequest(url: URL(string: "https://covidtracking.com")!, cachePolicy: .returnCacheDataElseLoad)), isActive: $showingCOVIDProject) {
                    Text("Data for this app is provided by COVID Tracking Project")
                        .font(.caption)
                }
                Text("The app is meant to inform the user.")
                Text("The data provided in not diagnostic.")
                Text("Stay safe and be healthy.")
                NavigationLink(destination: PopulationView(), isActive: $showingStatePopulations) {
                    Text("Population References used to calculate percentage tested")
                        .font(.caption)
                }
                
            }
        }
        .font(.body)
        .padding()
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
