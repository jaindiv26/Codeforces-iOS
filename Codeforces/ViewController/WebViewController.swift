//
//  WebViewController.swift
//  Codeforces
//
//  Created by Divyansh  Jain on 15/10/19.
//  Copyright © 2019 Divyansh  Jain. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var contestId = 0
    
    init (contestId: Int) {
        super.init(nibName: nil, bundle: nil)
        self.contestId = contestId
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var webView: WKWebView!
        webView = WKWebView(frame: CGRect.zero)
        webView.uiDelegate = self as? WKUIDelegate
        view = webView
        let contestUrl = URL(string: "https://codeforces.com/contest/" + String(contestId))
        let request = URLRequest(url: contestUrl!)
        webView.load(request)
    }
    
}
