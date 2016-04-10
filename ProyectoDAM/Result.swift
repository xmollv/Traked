//
//  TraktKeys.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 20/01/16.
//  Copyright © 2016 Xavi. All rights reserved.
//


import Foundation

public class Result {
	public var rank : Int?
	public var listed_at : String?
	public var type : String?
	public var showOrMovie : ShowOrMovie?
    public var last_watched_at : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let json4Swift_Base_list = Json4Swift_Base.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Json4Swift_Base Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Result]
    {
        var models:[Result] = []
        for item in array
        {
            models.append(Result(dictionary: item as! NSDictionary)!)
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
		if (dictionary["show"] != nil) { showOrMovie = ShowOrMovie(dictionary: dictionary["show"] as! NSDictionary) }
        if (dictionary["movie"] != nil) { showOrMovie = ShowOrMovie(dictionary: dictionary["movie"] as! NSDictionary) }
        if (dictionary["last_watched_at"] != nil) {last_watched_at = dictionary["last_watched_at"] as? String }
	}
    
    init (type: ShowOrMovie) {
        self.showOrMovie = type
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
		dictionary.setValue(self.showOrMovie?.dictionaryRepresentation(), forKey: "show")

		return dictionary
	}

}