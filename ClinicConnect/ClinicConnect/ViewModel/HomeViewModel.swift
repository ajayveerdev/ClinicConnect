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
        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                if let settings = try? JSONDecoder().decode(SettingsModel.self, from: data) {
//                    //print(settings)
//                    self.settingsModel = settings
//                } else {
//                    print("Invalid Response")
//                }
//            } else if let error = error {
//                print("HTTP Request Failed \(error)")
//            }
//        }
//        task.resume()
        HttpUtility.shared.request(urlRequest: request, resultType: SettingsModel.self) { result in
            self.settingsModel = result
        }
        homeGroup.leave()
        
        
        homeGroup.enter()
        let urlPet = URL(string: Constants.BaseUrl.baseAPI + "pets.json")!
        var requestPet = URLRequest(url: urlPet)
        requestPet.httpMethod = "get"
        requestPet.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let taskPet = URLSession.shared.dataTask(with: requestPet) { data, response, error in
//            if let data = data {
//                if let pets = try? JSONDecoder().decode(PetsModel?.self, from: data) {
//                    //print(pets)
//                    self.petsModel = pets
//                } else {
//                    print("Invalid Response")
//                }
//            } else if let error = error {
//                print("HTTP Request Failed \(error)")
//            }
//        }
//        taskPet.resume()
        
        HttpUtility.shared.request(urlRequest: requestPet, resultType: PetsModel.self) { result in
            self.petsModel = result
        }
        
        homeGroup.leave()
        
        
        // Dispatach Group Notify
        homeGroup.notify(queue: .main) { [weak self] in
            
            completion()
            
        }
        
    
        
    }
    
  
}






