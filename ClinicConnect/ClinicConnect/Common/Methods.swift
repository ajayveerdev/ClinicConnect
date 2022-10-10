//
//  Methods.swift
//  ClinicConnect
//
//  Created by Macbook on 08/10/22.
//

import Foundation
import UIKit

func showAlert(vc:UIViewController,title : String, message : String,_ completionhandler:(() -> ())? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: Constants.okay, style: UIAlertAction.Style.default, handler: nil))
    vc.present(alert, animated: true, completion: nil)
}

func getTimeToIntValue(timeInString: String)->Int {
    let calendar = Calendar(identifier: .gregorian)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = DATEFORMATTERS.HHMM
    guard let intHour = dateFormatter.date(from: timeInString) else { return 0}
    let timeInInt = calendar.component(.hour ,from: intHour)
    return timeInInt
    
}
