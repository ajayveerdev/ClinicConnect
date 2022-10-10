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

    func getOfficeHours(completion: @escaping (Bool) -> Void){
        let calendar = Calendar(identifier: .gregorian)
        let now = Date()
        let weekday = calendar.component(.weekday, from: now as Date)
        print(weekday)
        if weekday != 1 && weekday != 7 {
            let fullArr:[String] = self.settingsModel?.settings?.workHours?.components(separatedBy: " ") ?? []
            let startHour: String = fullArr[1]
            let endHour: String = fullArr[3]
            let startWorkinngHour = now.dateAt(hours:getTimeToIntValue(timeInString: startHour))
            let endWorkinngHour = now.dateAt(hours: getTimeToIntValue(timeInString: endHour))
            if now >= startWorkinngHour && now <= endWorkinngHour {
                completion(true)
            } else {
                completion(false)
            }
        } else {
            completion(false)
        }
    }
    
}






