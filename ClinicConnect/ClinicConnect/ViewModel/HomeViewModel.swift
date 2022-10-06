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
        request.httpMethod = HTTPHeaderFields.get
        request.setValue(HTTPHeaderFields.applicationJson, forHTTPHeaderField: HTTPHeaderFields.contentType)
        HttpUtility.shared.request(urlRequest: request, resultType: SettingsModel.self) { result,error  in
            if error == nil{
                self.settingsModel = result
            } else{
                print(error ?? "Error")
            }
            
            homeGroup.leave()
        }
        homeGroup.enter()
        let urlPet = URL(string: Constants.BaseUrl.baseAPI + "pets.json")!
        var requestPet = URLRequest(url: urlPet)
        requestPet.httpMethod = HTTPHeaderFields.get
        requestPet.setValue(HTTPHeaderFields.applicationJson, forHTTPHeaderField: HTTPHeaderFields.contentType)
        HttpUtility.shared.request(urlRequest: requestPet, resultType: PetsModel.self) { result,error  in
            if error == nil{
                self.petsModel = result
            } else{
                print(error ?? "Error")
            }
            homeGroup.leave()
        }
        homeGroup.notify(queue: .main) { [weak self] in
            completion()
        }
    }
    
}






