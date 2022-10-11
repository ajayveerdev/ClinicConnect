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
    

    func getURLRequest(endPint:String?) -> URLRequest {
        var request = URLRequest(url: URL(string: Constants.BaseUrl.baseAPI + (endPint ?? ""))!)
        request.httpMethod = HTTPHeaderFields.get
        request.setValue(HTTPHeaderFields.applicationJson, forHTTPHeaderField: HTTPHeaderFields.contentType)
        return request
    }

    func getConfigData(completion: @escaping () -> ()){
        let homeGroup = DispatchGroup()
        
        homeGroup.enter()
        HttpUtility.shared.request(urlRequest: getURLRequest(endPint: "config.json"), resultType: SettingsModel.self) { result,error  in
            if error == nil{
                self.settingsModel = result
            } else{
                print(error ?? "Error")
            }
            homeGroup.leave()
        }
        
        homeGroup.enter()
        HttpUtility.shared.request(urlRequest: getURLRequest(endPint: "pets.json"), resultType: PetsModel.self) { result,error  in
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
        if validateOfficeHours(){
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
        } else{
            completion(false)
        }

    }
    
    func validateOfficeHours() -> Bool{
        let workingHours = self.settingsModel?.settings?.workHours
        guard let workingHours = workingHours?.contains("M-F") else { return false }
        return workingHours ? true : false
    }
    
}






