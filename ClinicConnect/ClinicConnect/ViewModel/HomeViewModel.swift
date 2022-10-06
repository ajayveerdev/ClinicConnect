//
//  HomeViewModel.swift
//  ClinicConnect
//
//  Created by Macbook on 07/10/22.
//

import Foundation

class HomeViewModel{
    
    var settingsModel:SettingsModel?
    var petsModel: PetsModel?
    
    func getConfigData(completion: @escaping () -> ()){
        let homeGroup = DispatchGroup()
        homeGroup.enter()
        let url = URL(string: Constants.BaseUrl.baseAPI + "config.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        HttpUtility.shared.request(urlRequest: request, resultType: SettingsModel.self) { result in
            self.settingsModel = result
            homeGroup.leave()
        }
        homeGroup.enter()
        let urlPet = URL(string: Constants.BaseUrl.baseAPI + "pets.json")!
        var requestPet = URLRequest(url: urlPet)
        requestPet.httpMethod = "get"
        requestPet.setValue("application/json", forHTTPHeaderField: "Content-Type")
        HttpUtility.shared.request(urlRequest: requestPet, resultType: PetsModel.self) { result in
            self.petsModel = result
            homeGroup.leave()
        }
        homeGroup.notify(queue: .main) { [weak self] in
            completion()
        }
    }
    
}






