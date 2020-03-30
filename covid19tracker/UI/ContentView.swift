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
            //MARK:- StateView
            StatesView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("Numbers")
                    }
            }
            .tag(0)
            
            //MARK:- Info View
            StateInfoView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "info.circle")
                        Text("State Info")
                    }
            }
            .tag(1)
            
            //MARK:- Vids
            StatePressView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "tray.and.arrow.down")
                        Text("Press")
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
