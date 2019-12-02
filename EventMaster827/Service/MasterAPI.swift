//
//  MasterAPI.swift
//  EventMaster827
//
//  Created by mac on 9/30/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation


struct MasterAPI {
    
    let baseUrl = "https://app.ticketmaster.com/discovery/v2/"
    let attractionType = "attractions.json?countryCode=US&"
    let key = "apikey=zlipr3J5GWrzClYsAk3kbnAyqRLQc0JH"
    
    var getAttractionUrl: URL? {
        
        return URL(string: baseUrl + attractionType + key)
    }
    


}
