//
//  NetworkLayer.swift
//  Thursty
//
//  Created by Siddharth Joshi on 7/19/18.
//  Copyright © 2018 sjoshi. All rights reserved.
//

import Foundation
func CreateUpdateRequest(requestType: String, jsonParams: Data, url: String) -> Bool
{
    //Defining URL request
    let postURL =  URL(string: url)!
    var postRequest = URLRequest(url:postURL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30.0)
    //TODO: Insert error handling for request timeout
    
    //Setting the attributes of the postRequest
    postRequest.httpMethod = requestType
    postRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    postRequest.setValue("application/json", forHTTPHeaderField: "Accept")
    
    //Attemps to serialize the JSON object to save to request.httpBody
    postRequest.httpBody = jsonParams
    
    //URL session data task that makes actual request
    URLSession.shared.dataTask(with: postRequest, completionHandler: { (data, response, error) -> Void in
        if error != nil
        {
            print("POST Request: Communication error: \(error!)")
            return
        }
        
        if data != nil
        {
            do {
                let resultObject = try JSONSerialization.jsonObject(with: data!, options: [])
                DispatchQueue.main.async(execute: {
                    print("Results from POST Request:\n\(resultObject)")
                })
            } catch {
                DispatchQueue.main.async(execute: {
                    print("Unable to parse JSON response")
                })
            }
            return
        }
        else
        {
            DispatchQueue.main.async(execute: { print("Received empty response.") })
            return
        }
    }).resume()
    return true
}


