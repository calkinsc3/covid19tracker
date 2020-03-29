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
    
    let urlRequest: URLRequest?
    
    func makeCoordinator() -> StatesWebView.Coordinator {
        return Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero)
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let givenURLRequest = self.urlRequest {
            webView.load(givenURLRequest)
        }
            
    }
    
    //MARK:- WebDelegate Coordinator
    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        
        var parent: StatesWebView
        
        init(_ webView: StatesWebView) {
            self.parent = webView
            
        }
        
        //MARK:- Navigation Delegate
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            
//            let alertController = UIAlertController(title: "Done", message: "WebContent did finish", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//            present(alertController, animated: true)
            
        }
        
        func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
            
        }
        
        //MARK:- UI Delegate
        func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
            
            
            
        }
        
        
        
        
    }
}

//struct StatesWebView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatesWebView(stateInfo: StateInfoElement.placeholder)
//    }
//}
