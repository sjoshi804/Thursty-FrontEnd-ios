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
    
    @IBAction func createParty (sender: AnyObject)
    {
       let newParty = Party(createdAt: "2018-07-19T12:14:40.524656Z", eventName: "Encoder Test", hostedBy: "UCLA:105032378", hostedByNameCache: "Me", location: "Westwood", partyid: "UCLA:105032378-14", status: "Active", time: "2018-07-19T12:14:40.524656Z")
        
    }
}


