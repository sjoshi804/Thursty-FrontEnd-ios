//
//  PartyModel.swift
//  Thursty
//
//  Created by Siddharth Joshi on 7/19/18.
//  Copyright © 2018 sjoshi. All rights reserved.
//

struct Party: Codable
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

