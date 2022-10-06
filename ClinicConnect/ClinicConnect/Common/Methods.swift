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

func getOfficeHours(vc:UIViewController){
    let calendar = Calendar(identifier: .gregorian)
    let now = Date()
    let weekday = calendar.component(.weekday, from: now as Date)
    print(weekday)
    if weekday != 1 && weekday != 7 {
        var fullArr:[String] = []
        if let vcLocal = vc as? HomeViewController {
            fullArr = vcLocal.homeViewModel.settingsModel?.settings?.workHours?.components(separatedBy: " ") ?? []
        }
        let startHour: String = fullArr[1]
        let endHour: String = fullArr[3]
        let startWorkinngHour = now.dateAt(hours:getTimeToIntValue(timeInString: startHour))
        let endWorkinngHour = now.dateAt(hours: getTimeToIntValue(timeInString: endHour))
        if now >= startWorkinngHour && now <= endWorkinngHour {
            showAlert(vc: vc, title: Constants.alert, message: Constants.thankYou)
        } else {
            showAlert(vc: vc, title: Constants.alert, message: Constants.workHoursEnded)
        }
    } else {
        showAlert(vc: vc, title: Constants.alert, message: Constants.workHoursEnded)
    }
}

func getTimeToIntValue(timeInString: String)->Int {
    let calendar = Calendar(identifier: .gregorian)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = DATEFORMATTERS.HHMM
    guard let intHour = dateFormatter.date(from: timeInString) else { return 0}
    let timeInInt = calendar.component(.hour ,from: intHour)
    return timeInInt
    
}
