//
//  Extension.swift
//  ClinicConnect
//
//  Created by Macbook on 08/10/22.
//

import Foundation


extension Date {

    func dateAt(hours: Int) -> Date

    {
        let calendar = Calendar(identifier: .gregorian)

        var date_components = calendar.dateComponents([.year,.month,.day], from: self)

        date_components.hour = hours

        date_components.second = 0

        
        let newDate = calendar.date(from: date_components)!

        return newDate

    }

}
