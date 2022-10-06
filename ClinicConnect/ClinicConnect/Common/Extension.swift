//
//  Extension.swift
//  ClinicConnect
//
//  Created by Macbook on 08/10/22.
//

import Foundation
import UIKit

extension Date {
    
    func dateAt(hours: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        var date_components = calendar.dateComponents([.year,.month,.day], from: self)
        date_components.hour = hours
        date_components.second = 0
        let newDate = calendar.date(from: date_components)!
        return newDate
    }
}

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        if url == nil {return}
        self.image = nil
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .medium)
        activityIndicator.frame = CGRect(x: self.frame.height/2 - 20, y:  self.frame.width/2 - 20, width: 20, height: 20)
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                    activityIndicator.removeFromSuperview()
                }
            }
        }).resume()
    }
}
