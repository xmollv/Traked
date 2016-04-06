//
//  Helper.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 20/01/16.
//  Copyright © 2016 Xavi. All rights reserved.
//

import Foundation

class Helper {
    
    let clientId = "9a7063ad7ac64b66813a3085d48eb41f03a48b54bb8b8353bb64aa3aef619236"
    let clientSecret = "000cde0af13d6278304a68fd6771a55097d74a8ff31e46e4e48d0cc86a9c1c02"
    let redirectUri = "ProyectoDAM://x.com"
    
    func getApiHeaders() -> [String : String] { return ["Content-Type":"application/json", "trakt-api-version":"2", "trakt-api-key": clientId, "Authorization" : "Bearer \(Helper().getUserToken()!)"]}
    
    func getUserToken() -> String? {
        if let token = NSUserDefaults.standardUserDefaults().objectForKey("access_token") {
            return "\(token)"
        }
        return nil
    }
}