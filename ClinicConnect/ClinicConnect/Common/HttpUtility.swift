//
//  HttpUtility.swift
//  ClinicConnect
//
//  Created by Macbook on 07/10/22.
//

import Foundation

class HttpUtility{
    
     enum HTTPStatusCode: Int {
      case ok = 200
      case serverError = 500
      case notFound = 404
      case badRequest = 400
   
      public func code() -> Int {
        return self.rawValue
      }
    }
    
    static let shared = HttpUtility()
    
    private init(){}
    
    public func request<T:Decodable>(urlRequest:URLRequest, resultType: T.Type, completionHandler: @escaping(_ result:T?, _ error:String?) -> Void){
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
               
                switch httpResponse.statusCode{
                case HTTPStatusCode.ok.code():
                    if let data = data {
                        if let response = try? JSONDecoder().decode(T?.self, from: data) {
                            completionHandler(response, nil)
                        } else {
                            //print("Invalid Response")
                            completionHandler(nil, "Invalid Response")
                        }
                    }
                case HTTPStatusCode.serverError.code():
                    //print("Server Error: \(httpResponse.statusCode)")
                    completionHandler(nil, "Server Error")
                case HTTPStatusCode.notFound.code():
                    //print("Not Found: \(httpResponse.statusCode)")
                    completionHandler(nil, "Not Found")
                case HTTPStatusCode.badRequest.code():
                    //print("Bad Request: \(httpResponse.statusCode)")
                    completionHandler(nil, "Bad Request")
                default:
                    break
                }
                
            }
            

        }
        task.resume()
    }
}
