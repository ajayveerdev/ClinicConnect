//
//  ActivityIndicator.swift
//  ClinicConnect
//
//  Created by Macbook on 06/10/22.
//

import Foundation
import UIKit

    var activityIndicator: UIActivityIndicatorView!
    
    func addActivityIndicator(style: UIActivityIndicatorView.Style, view: UIView, frame: CGRect){
        activityIndicator = UIActivityIndicatorView.init(style: style)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.frame =  frame
        view.addSubview(activityIndicator)
        showActivityIndicator(show: true)
    }
    
    func showActivityIndicator(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            DispatchQueue.main.async {
                activityIndicator.removeFromSuperview()
            }
            activityIndicator.stopAnimating()
            
        }
    }


