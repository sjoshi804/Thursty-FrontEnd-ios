//
//  NetworkingLayer.swift
//  Thursty
//
//  Created by Siddharth Joshi on 7/24/18.
//  Copyright © 2018 sjoshi. All rights reserved.
//

import Foundation
class NetworkingLayer
{
    static func CreateUpdateRequest (requestURL: String, requestType: String, jsonParams: Data) -> Bool
    {
        let requestURL = URL(string: requestURL)!
        var request = URLRequest(url: requestURL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 15.0)
        request.httpMethod = requestType
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = jsonParams
        var apiRequestSuccess = false
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if error != nil
            {
                print("POST Request: Communication error: \(error!)")
                
            }
            if data != nil
            {
                do
                {
                    _ = try JSONSerialization.jsonObject(with: data!, options: [])
                    DispatchQueue.main.async(execute: {
                        print("API Request Success")
                    })
                    apiRequestSuccess = true
                    return
                }
                    
                catch
                {
                    DispatchQueue.main.async(execute: {
                        print("Failure")
                    })
                }
            }
            
            else {
                DispatchQueue.main.async(execute: {
                    print("Received empty response.")
                })
            }
            
        }).resume()
        
        return apiRequestSuccess
    }
    
    static func GetListRequest(requestURL: String)
    {
        //TODO
        //Read up about generics
    }
}
