//
//  TraktKeys.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 20/01/16.
//  Copyright © 2016 Xavi. All rights reserved.
//

import Foundation

public class Poster {
	public var full : String?
	public var medium : String?
	public var thumb : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let poster_list = Poster.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Poster Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Poster]
    {
        var models:[Poster] = []
        for item in array
        {
            models.append(Poster(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let poster = Poster(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Poster Instance.
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