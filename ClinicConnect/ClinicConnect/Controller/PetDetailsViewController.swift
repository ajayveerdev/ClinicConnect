//
//  PetDetailsViewController.swift
//  ClinicConnect
//
//  Created by Macbook on 08/10/22.
//

import UIKit
import WebKit

class PetDetailsViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    @IBOutlet weak var webViewContent: WKWebView!
    var activityIndicator: UIActivityIndicatorView!
    var petsModel: Pets?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = petsModel?.title

        webViewContent.navigationDelegate = self

        let frame = CGRect(x: self.view.frame.width/2 - 10, y:  self.view.frame.height/2 - 20, width: 20, height: 20)
        addActivityIndicator(style: .medium, view: self.view, frame: frame)
        
        let url = URL(string: petsModel?.content_url ?? "")!
        webViewContent.load(URLRequest(url: url))
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showActivityIndicator(show: false)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator(show: true)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showActivityIndicator(show: false)
    }
    
}
