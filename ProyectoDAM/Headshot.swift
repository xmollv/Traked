//
//  TraktKeys.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 09/03/16.
//  Copyright © 2016 TaniaXavi. All rights reserved.
//

import Foundation

public class Headshot {
	public var full : String?
	public var medium : String?
	public var thumb : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let headshot_list = Headshot.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Headshot Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Headshot]
    {
        var models:[Headshot] = []
        for item in array
        {
            models.append(Headshot(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let headshot = Headshot(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Headshot Instance.
*/
	required public init?(dictionary: NSDictionary) {

		full = dictionary["full"] as? String
		medium = dictionary["medium"] as? String
		thumb = dictionary["thumb"] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.full, forKey: "full")
		dictionary.setValue(self.medium, forKey: "medium")
		dictionary.setValue(self.thumb, forKey: "thumb")

		return dictionary
	}

}