//
//  ContentView.swift
//  covid19tracker
//
//  Created by William Calkins on 3/27/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userData: UserData
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab){
            //MARK:- State Numbers
            StatesView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("Numbers")
                    }
            }
            .tag(0)
            //MARK:- State Sources
            StateInfoView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "info.circle")
                        Text("State Sources")
                    }
            }
            .tag(1)
            
            //MARK:- About
            AboutView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "a.circle")
                        Text("About")
                    }
            }
            .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
