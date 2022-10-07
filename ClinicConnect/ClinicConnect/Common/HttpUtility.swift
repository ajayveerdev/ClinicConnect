//
//  HttpUtility.swift
//  ClinicConnect
//
//  Created by Macbook on 07/10/22.
//

import Foundation

struct HttpUtility{
    
    static let shared = HttpUtility()
    
    private init(){}
    
    public func request<T:Decodable>(urlRequest:URLRequest, resultType: T.Type, completionHandler: @escaping(_ result:T?) -> Void){
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                if let settings = try? JSONDecoder().decode(T?.self, from: data) {
                    //print(settings)
                    completionHandler(settings)
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()

        
    }
    
}
