//
//  SettingsModel.swift
//  ClinicConnect
//
//  Created by Macbook on 07/10/22.
//

import Foundation


struct SettingsModel: Codable {
    var settings : Settings?

}

struct Settings : Codable {
    var isChatEnabled: Bool?
    var isCallEnabled: Bool?
    var workHours: String?
}


