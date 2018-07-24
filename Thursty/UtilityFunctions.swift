//
//  UtilityFunctions.swift
//  Thursty
//
//  Created by Siddharth Joshi on 7/19/18.
//  Copyright © 2018 sjoshi. All rights reserved.
//

import Foundation

//Pass the description of a date to this function to return a python compatible date field

class UtilityFunctions
{
    static func convertDateToString(rawDate: Date) -> String
    {
        let APIDateFormat = DateFormatter()
        APIDateFormat.dateFormat = "yyyy-MM-ddTHH:mm:ssZ"
        var formattedDate = ""
        formattedDate = APIDateFormat.string(from: rawDate)
        return formattedDate.description
    }
}
