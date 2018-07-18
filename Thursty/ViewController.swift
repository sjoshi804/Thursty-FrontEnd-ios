//
//  ViewController.swift
//  Thursty
//
//  Created by Siddharth Joshi on 7/7/18.
//  Copyright © 2018 sjoshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    //Definition of Interface Builder Outlets
    @IBOutlet var partyName: UITextField!
    @IBOutlet var partyTime: UIDatePicker!
    @IBOutlet var partyLocation: UITextField!
    @IBOutlet var createPartyButton: UIButton!
    
    struct Party: Decodable
    {
        let createdAt: String
        let eventName: String
        let hostedBy: String
        let hostedByNameCache: String
        let location: String
        let partyid: String
        let status: String
        let time: String
    }
    
    @IBAction func getPartyList(sender: AnyObject)
    {
        let getURL = URL(string: "https://test-thursday.herokuapp.com/party/all/")!
        var getRequest = URLRequest(url: getURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        getRequest.httpMethod = "GET"
        getRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        getRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: getRequest, completionHandler: { (data, response, error) -> Void in
            if error != nil { print("GET Request: Communication error: \(error!)") }
            if data != nil {
                do {
                    let resultObject = try JSONSerialization.jsonObject(with: data!, options: [])
                    DispatchQueue.main.async(execute: {
                        print("Results from GET https://httpbin.org/get?bar=foo :\n\(resultObject)") })
                } catch {
                    DispatchQueue.main.async(execute: {
                        print("Unable to parse JSON response")
                    })
                }
            } else {
                DispatchQueue.main.async(execute: {
                    print("Received empty response.")
                })
            }
        }).resume()
    }
}

