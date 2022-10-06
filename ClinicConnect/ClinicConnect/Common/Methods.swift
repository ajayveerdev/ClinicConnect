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
        let firstValue: String = fullArr[1]
        let lastValue: String = fullArr[3]
        let startWorkinngHour = now.dateAt(hours: Int(Double(firstValue) ?? 9))
        let endWorkinngHour = now.dateAt(hours: Int(Double(lastValue) ?? 18))
        if now >= startWorkinngHour && now <= endWorkinngHour {
            print("The time is between")
            showAlert(vc: vc, title: Constants.alert, message: Constants.thankYou)
        } else {
            print("The time is not between")
            showAlert(vc: vc, title: Constants.alert, message: Constants.workHoursEnded)
        }
    } else {
        print("The time is not between")
        showAlert(vc: vc, title: Constants.alert, message: Constants.workHoursEnded)
    }
}
