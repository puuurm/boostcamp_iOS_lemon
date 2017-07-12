//
//  WebViewController.swift
//  Sample
//
//  Created by yangpc on 2017. 7. 5..
//  Copyright © 2017년 yangpc. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        
        // frame을 .zero로 설정한 이유는??
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        // uiDelegate의 역할은 무엇이길래 여기에 할당하였을까요?
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let myURL = URL(string: "https://www.bignerdranch.com") {
            let myRequest = URLRequest(url: myURL)
            webView.load(myRequest)
        }
    }
    
    
}

