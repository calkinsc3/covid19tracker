//
//  StatePressView.swift
//  covid19tracker
//
//  Created by William Calkins on 3/29/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import SwiftUI

struct StatePressView: View {
    
    @ObservedObject var statePressViewModel = StatePressViewModel()
    
    var body: some View {
        NavigationView {
            List(self.statePressViewModel.statePressResult) { press in
                NavigationLink(destination: StateWebController(urlRequest: press.urlRequest)) {
                    StatePressCellView(statePressInfo: press)
                        .padding()
                }
            }
            .navigationBarTitle("Press")
        }
    }
}

struct StatePressCellView: View {
    
    let statePressInfo: PressDatum
    
    var body: some View {
        VStack {
            Text(self.statePressInfo.title)
                .font(.body)
            Text("Published Date: \(statePressInfo.datePublishedDisplay ?? statePressInfo.publishDate)")
                .font(.caption)
        }
        .multilineTextAlignment(.leading)
    }
}

struct StatePressView_Previews: PreviewProvider {
    static var previews: some View {
        StatePressView()
    }
}
