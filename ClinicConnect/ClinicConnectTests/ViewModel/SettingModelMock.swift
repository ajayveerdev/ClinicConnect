//
//  SettingModelMock.swift
//  ClinicConnectTests
//
//  Created by Macbook on 10/10/22.
//

import Foundation
@testable import ClinicConnect
struct SettingModelMock{
    var settings: Settings?
   
    init() {
        settings = Settings(isChatEnabled: true, isCallEnabled: true, workHours: "M-F 9:00 - 18:00")
    }
    func getSettingMock() -> SettingsModel {
        let settingsModel = SettingsModel(settings: settings)
        return settingsModel
    }
}
