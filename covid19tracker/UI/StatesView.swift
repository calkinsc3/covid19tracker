//
//  StatesView.swift
//  covid19tracker
//
//  Created by William Calkins on 3/27/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import SwiftUI

struct StatesView: View {
    
    @ObservedObject var statesViewModel = StatesViewModel()
    
    var body: some View {
        List(self.statesViewModel.stateResults) { state in
            StateCellView(state: state)
        }
    }
}

struct StateCellView: View {
    
    let state: StateData
    
    var body: some View {
        HStack {
            Text(state.state)
            Text(String(state.positive ?? 0))
            Text(String(state.death ?? 0))
        }
    }
}

struct StatesView_Previews: PreviewProvider {
    static var previews: some View {
        StatesView()
    }
}
