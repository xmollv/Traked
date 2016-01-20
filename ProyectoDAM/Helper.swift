//
//  Helper.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 20/01/16.
//  Copyright © 2016 TaniaXavi. All rights reserved.
//

import Foundation

class Helper {
    
    func getApiHeaders() -> [String : String] { return ["Content-Type":"application/json", "trakt-api-version":"2", "trakt-api-key":TraktKeys().clientId]}
    
    func getUserName () -> String { return "ProjecteDAM" }
}