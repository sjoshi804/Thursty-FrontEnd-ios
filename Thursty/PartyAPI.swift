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
    static func createParty(name: String, time: String, location:String) -> Bool
    {
        
        let newParty = Party(createdAt: time, eventName: name, hostedBy: "UCLA:105032378", hostedByNameCache: "Siddharth", location: location, partyid: "UCLA:105032378-100", status: "Upcoming", time: time)
        return NetworkingLayer.CreateUpdateRequest(requestURL: Constants.partyCreateURL, requestType: "POST", jsonParams: newParty)
    }
    
    static func getPartyList() -> [Party]
    {
        //Dummy object to indicate type
        let dummy = Party(createdAt: "", eventName: "", hostedBy: "", hostedByNameCache: "", location: "", partyid: "", status: "", time: "")
        return NetworkingLayer.GetListRequest(requestURL: Constants.partyCreateURL, returnType: dummy)!
    }
    
    static func getSingleParty() -> Party
    {
        //Dummy object to indicate type
        let dummy = Party(createdAt: "", eventName: "", hostedBy: "", hostedByNameCache: "", location: "", partyid: "", status: "", time: "")
        return NetworkingLayer.GetObjRequest(requestURL: Constants.partyCreateURL, returnType: dummy)!
    }
    
    //Mark party as started for users to see
    static func activateParty() -> Bool
    {
        return true
    }
    
}
