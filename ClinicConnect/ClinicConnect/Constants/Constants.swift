//
//  Constants.swift
//  ClinicConnect
//
//  Created by Macbook on 07/10/22.
//

import Foundation

// MARK: - Constants
struct Constants {
    
    struct BaseUrl {
//        static let baseAPI =  "https://raw.githubusercontent.com/ajayveerdev/files/main/"
        static let baseAPI = "http://18.191.26.122/veer/"
    }
    
    static let okay = "Okay"
    static let pleaseCheckInternetConnection = "Please Check Internet Connection"
    static let newtworkError = "Network Alert"
    static let noDatatext = "No Data Available"
    static let officeHours = "Office Hours:"
    static let alert = "Alert"
    static let thankYou = "Thank you for getting in touch with us. We’ll get back to you as soon as possible"
    static let workHoursEnded = "Work hours has ended. Please contact us again on the next work day"
    
    struct TableViewCell {
        static let petTableViewCell = "PetTableViewCell"
    }
    
    struct ViewController {
        static let petDetailsViewController = "PetDetailsViewController"
    }
}

// MARK: - Date formatters
struct DATEFORMATTERS {
    static let HHMM: String = "HH:mm"
}


// MARK: - Screen Name
struct ScreenTitle {
    static let home = "Home"
    static let petDetails = "Pet Details"
    
}

// MARK: - Parameter Name
struct HTTPHeaderFields {
    static let get = "get"
    static let applicationJson = "application/json"
    static let contentType = "Content-Type"
}
