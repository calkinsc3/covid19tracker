//
//  AboutView.swift
//  covid19tracker
//
//  Created by William Calkins on 4/19/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            Image("COVIDIcon")
            .resizable()
                .frame(width: 130, height: 130, alignment: .center)
            Text("Thanks to all that downloaded this app")
                .font(.caption)
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
