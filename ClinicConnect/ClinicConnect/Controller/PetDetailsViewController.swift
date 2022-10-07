//
//  PetDetailsViewController.swift
//  ClinicConnect
//
//  Created by Macbook on 08/10/22.
//

import UIKit
import WebKit

class PetDetailsViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    var webView: WKWebView!
    var activityIndicator: UIActivityIndicatorView!
    var petsModel: Pets?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = petsModel?.title
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.color = .red
        view.addSubview(activityIndicator)
        
        let url = URL(string: petsModel?.content_url ?? "")!
        webView.load(URLRequest(url: url))
        
    }
    
    func showActivityIndicator(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
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
