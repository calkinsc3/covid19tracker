//
//  StatesWebView.swift
//  covid19tracker
//
//  Created by William Calkins on 3/29/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import SwiftUI
import WebKit
import UIKit

struct StateWebController: UIViewControllerRepresentable {
    
    let urlRequest: URLRequest?
    
    func makeUIViewController(context: Context) -> StateInfoViewController {
        
        let stateInfoViewController = StateInfoViewController()

        if let givenRequest = self.urlRequest {
            stateInfoViewController.webView.load(givenRequest)
        }
        return stateInfoViewController
    }
    
    func updateUIViewController(_ webViewController: StateInfoViewController, context: Context) {
        if let givenRequest = self.urlRequest {
            webViewController.webView.load(givenRequest)
        }
    }
    
    class StateInfoViewController : UIViewController {
        
        lazy var webView = WKWebView(frame: .zero)
        lazy var progressBar = UIProgressView(progressViewStyle: .default)
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.webView.frame = self.view.frame
            self.view.addSubview(self.webView)
            
            //add progress bar
            self.view.addSubview(self.progressBar)
            self.progressBar.translatesAutoresizingMaskIntoConstraints = false
            self.view.addConstraints([
                self.progressBar.topAnchor.constraint(equalTo: self.view.topAnchor),
                self.progressBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.progressBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
            
            //set progress bar
            self.progressBar.progress = 0.1
            webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
            
        }
        
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == "estimatedProgress" {
                self.progressBar.progress = Float(self.webView.estimatedProgress)
            }
        }
    }
}

//struct StatesWebView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatesWebView(stateInfo: StateInfoElement.placeholder)
//    }
//}
