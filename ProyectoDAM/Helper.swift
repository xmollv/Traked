//
//  Helper.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 20/01/16.
//  Copyright © 2016 TaniaXavi. All rights reserved.
//

import Foundation

class Helper {
    
    let clientId = "bd184c0b9d554dd55a34e8b73e0a294524a8b66d4ae56da7261558c846645bf5"
    let clientSecret = "cfbb7eb462977c0cab69e2cfae90347723ddab0b5046ca630112fc9f4a73eff6"
    let redirectUri = "ProyectoDAM://x.com"
    
    func getApiHeaders() -> [String : String] { return ["Content-Type":"application/json", "trakt-api-version":"2", "trakt-api-key": clientId, "Authorization" : "Bearer \(Helper().getUserToken())"]}
    
    func getUserToken() -> String {
        if let token = NSUserDefaults.standardUserDefaults().objectForKey("access_token") {
            return String(token)
        }
        return ""
    }
}