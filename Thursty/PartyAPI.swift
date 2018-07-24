//
//  PartyAPI.swift
//  Thursty
//
//  Created by Siddharth Joshi on 7/19/18.
//  Copyright © 2018 sjoshi. All rights reserved.
//

import Foundation


class PartyAPI
{
    static func createParty(newParty: Party) -> Bool
    {
        let jsonEncoder = JSONEncoder()
        do
        {
            let jsonParams = try jsonEncoder.encode(newParty)
            return NetworkingLayer.CreateUpdateRequest(requestURL: Constants.partyCreateURL, requestType: "POST", jsonParams: jsonParams)
        }
        catch
        {
            print("Error: unable to add parameters to POST request.")
            return false
        }
    }
    
    static func getPartyList() -> [Party]
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

}
