//
//  PartyModel.swift
//  Thursty
//
//  Created by Siddharth Joshi on 7/19/18.
//  Copyright © 2018 sjoshi. All rights reserved.
//

struct Party: Codable
{
    var createdAt: String
    var eventName: String
    var hostedBy: String
    var hostedByNameCache: String
    var location: String
    var partyid: String
    var status: String
    var time: String
}

