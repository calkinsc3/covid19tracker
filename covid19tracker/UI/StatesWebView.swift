//
//  StatesWebView.swift
//  covid19tracker
//
//  Created by William Calkins on 3/29/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import SwiftUI
import WebKit

struct StatesWebView: UIViewRepresentable {
    
    let stateInfo: StateInfoElement
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.load(stateInfo.urlRequest!)
    }
}

struct StatesWebView_Previews: PreviewProvider {
    static var previews: some View {
        StatesWebView(stateInfo: StateInfoElement.placeholder)
    }
}
