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
    
    var body: some View {
        VStack {
            
            Image("COVIDIcon")
                .resizable()
                .frame(width: 150, height: 150, alignment: .center)
            Text("Data for this app is provided by: ")
                .font(.caption)
            Button(action: {
                self.showingCOVIDProject.toggle()
            }) {
                Text("The COVID Tracking Project")
                    .font(.subheadline)
            }
            
            Text("The app is meant to inform the user.")
            Text("The data provided in not diagnostic.")
            Text("Stay safe and be healthy.")
            
        }
        .font(.body)
        .padding()
        .sheet(isPresented: $showingCOVIDProject, content: {
            StateWebController(urlRequest: URLRequest(url: URL(string: "https://covidtracking.com")!, cachePolicy: .returnCacheDataElseLoad))
        })
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
