//
//  TraktKeys.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 24/01/16.
//  Copyright © 2016 TaniaXavi. All rights reserved.
//


import Foundation

public class Movies {
    public var rank : Int?
    public var listed_at : String?
    public var type : String?
    public var movie : ShowOrMovie?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let json4Swift_Base_list = Json4Swift_Base.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Json4Swift_Base Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [TVShows]
    {
        var models:[TVShows] = []
        for item in array
        {
            models.append(TVShows(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let json4Swift_Base = Json4Swift_Base(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Json4Swift_Base Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        rank = dictionary["rank"] as? Int
        listed_at = dictionary["listed_at"] as? String
        type = dictionary["type"] as? String
        if (dictionary["movie"] != nil) { movie = ShowOrMovie(dictionary: dictionary["movie"] as! NSDictionary) }
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.rank, forKey: "rank")
        dictionary.setValue(self.listed_at, forKey: "listed_at")
        dictionary.setValue(self.type, forKey: "type")
        dictionary.setValue(self.movie?.dictionaryRepresentation(), forKey: "movie")
        
        return dictionary
    }
    
}