//
//  TraktKeys.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 25/01/16.
//  Copyright © 2016 Xavi. All rights reserved.
//

import Foundation

public class Seasons {
	public var number : Int?
	//public var ids : Ids?
	public var episodes : Array<Episodes>?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let json4Swift_Base_list = Json4Swift_Base.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Json4Swift_Base Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Seasons]
    {
        var models:[Seasons] = []
        for item in array
        {
            models.append(Seasons(dictionary: item as! NSDictionary)!)
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

		number = dictionary["number"] as? Int
		//if (dictionary["ids"] != nil) { ids = Ids(dictionary: dictionary["ids"] as! NSDictionary) }
		if (dictionary["episodes"] != nil) { episodes = Episodes.modelsFromDictionaryArray(dictionary["episodes"] as! NSArray) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.number, forKey: "number")
		//dictionary.setValue(self.ids?.dictionaryRepresentation(), forKey: "ids")

		return dictionary
	}

}