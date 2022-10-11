//
//  PetsModelMock.swift
//  ClinicConnectTests
//
//  Created by Macbook on 10/10/22.
//

import Foundation
@testable import ClinicConnect
struct PetsModelMock{
    var pets: [Pets] = []
    init() {
         pets = [Pets(image_url: "testing", title: "testing", content_url: "testing", date_added: "testing"),
                 Pets(image_url: "testing", title: "testing", content_url: "testing", date_added: "testing")
         ]
    }
    func getPetsMock() -> PetsModel {
        let petsModel = PetsModel(pets: pets)
        return petsModel
    }
}
