//
//  PartyAPI.swift
//  Thursty
//
//  Created by Siddharth Joshi on 7/19/18.
//  Copyright © 2018 sjoshi. All rights reserved.
//

import Foundation

//POST Request to create party -- returns true if successful
func createParty(newParty: Party) -> Bool
{
    //Defining URL request
    let postURL =  URL(string: Constants.partyCreateURL)!
    var postRequest = URLRequest(url:postURL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30.0)
    //TODO: Insert error handling for request timeout
    
    //Setting the attributes of the postRequest
    postRequest.httpMethod = "POST"
    postRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    postRequest.setValue("application/json", forHTTPHeaderField: "Accept")
    
    //Creating jsonEncoder object to encode the party object into JSON
    let jsonEncoder = JSONEncoder()
    
    //Attemps to serialize the JSON object to save to request.httpBody
    do
    {
        let jsonParams = try JSONSerialization.data(withJSONObject: jsonEncoder.encode(newParty), options: [])
        postRequest.httpBody = jsonParams
    }
    catch
    {
        print("Error: unable to add parameters to POST request.")
        return false
    }
    
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
                    print("Results from POST https://httpbin.org/post :\n\(resultObject)")
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

func getPartyList() -> [Party]
{
    let getURL = URL(string: "https://test-thursday.herokuapp.com/party/all/")!
    var getRequest = URLRequest(url: getURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
    getRequest.httpMethod = "GET"
    getRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    getRequest.setValue("application/json", forHTTPHeaderField: "Accept")
    var party: [Party]?
    URLSession.shared.dataTask(with: getRequest, completionHandler: { (data, response, error) -> Void in
        if error != nil
        {
            print("GET Request: Communication error: \(error!)")
            return
        }
        
        if data != nil
        {
            guard let response = try? JSONDecoder().decode([Party].self, from:data!) else
            {
                print("Error: Couldn't decode data into Party")
                return
            }
            party = response
            return
        }
        else
        {
            DispatchQueue.main.async(execute: { print("Received empty response.") })
            return
        }
    }).resume()
    return party!
}


