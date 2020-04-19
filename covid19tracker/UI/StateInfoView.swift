//
//  StateInfoView.swift
//  covid19tracker
//
//  Created by William Calkins on 3/29/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import SwiftUI

struct StateInfoView: View {
    
    @EnvironmentObject var userData: UserData
    
    @ObservedObject var statesInfoViewModel = StateInfoViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(self.statesInfoViewModel.stateInfo) { stateInfo in
                    NavigationLink(destination: StateWebController(urlRequest: stateInfo.urlRequest), label: {
                        StateInfoCellView(stateInfo: stateInfo)
                    })
                    .navigationBarTitle("State Sources")
                }
            }
        }
    }
}

struct StateInfoCellView: View {
    
    let stateInfo: StateInfoElement
    
    var body: some View {
        Text(stateInfo.name)
    }
    
}

struct StateInfoView_Previews: PreviewProvider {
    static var previews: some View {
        StateInfoView()
    }
}
