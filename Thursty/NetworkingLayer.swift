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
    //For POST, and PATCH requests with JSON objects to send
    static func CreateUpdateRequest <Obj: Encodable>(requestURL: String, requestType: String, jsonParams: Obj) -> Bool
    {
        let requestURL = URL(string: requestURL)!
        var request = URLRequest(url: requestURL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 15.0)
        request.httpMethod = requestType
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        var apiRequestSuccess = false
        
        let jsonEncoder = JSONEncoder()
        do
        {
            let jsonParams = try jsonEncoder.encode(jsonParams)
            request.httpBody = jsonParams
        }
        catch
        {
            print("Error: unable to add parameters to POST request.")
            return false
        }
        
        
        
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
    
    //For API GET Request returning a single object
    static func GetListRequest<Obj: Decodable>(requestURL: String, returnType: Obj) -> [Obj]?
    {
        //Request Parameters Initialization
        let getURL = URL(string: requestURL)!
        var getRequest = URLRequest(url: getURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 15.0)
        getRequest.httpMethod = "GET"
        getRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        getRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        var objList: [Obj]?
        
        URLSession.shared.dataTask(with: getRequest, completionHandler: { (data, response, error) -> Void in
            if error != nil
            {
                print("GET Request: Communication error: \(error!)")
                return
            }
            
            if data != nil
            {
                guard let response = try? JSONDecoder().decode([Obj].self, from:data!) else
                {
                    print("Error: Couldn't decode data into Party")
                    return
                }
                objList = response
                return
            }
            else
            {
                DispatchQueue.main.async(execute: { print("Received empty response.") })
                return
            }
        }).resume()
        return objList
    }
    
    //For API GET Request returning a single object
    static func GetObjRequest<Obj: Codable>(requestURL: String, returnType: Obj) -> Obj?
    {
        //Request Parameters Initialization
        let getURL = URL(string: requestURL)!
        var getRequest = URLRequest(url: getURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 15.0)
        getRequest.httpMethod = "GET"
        getRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        getRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        var obj: Obj?
        
        URLSession.shared.dataTask(with: getRequest, completionHandler: { (data, response, error) -> Void in
            if error != nil
            {
                print("GET Request: Communication error: \(error!)")
                return
            }
            
            if data != nil
            {
                guard let response = try? JSONDecoder().decode(Obj.self, from:data!) else
                {
                    print("Error: Couldn't decode data into Party")
                    return
                }
                obj = response
                return
            }
            else
            {
                DispatchQueue.main.async(execute: { print("Received empty response.") })
                return
            }
        }).resume()
        return obj
    }
    
    //Exclusively for put requests as only one field exists within the Json object and hence doesn't have any corresponding data model
    static func PutRequest(requestURL: String, jsonObj: Dictionary<String, String>) -> Bool
    {
        let requestURL = URL(string: requestURL)!
        var request = URLRequest(url: requestURL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 15.0)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        var apiRequestSuccess = false
        
        do
        {
            let jsonParams = try JSONSerialization.data(withJSONObject: jsonObj, options: [])
            request.httpBody = jsonParams
        }
        catch
        {
            print("Error: unable to add parameters to POST request.")
            return false
        }
        
        
        
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
}
