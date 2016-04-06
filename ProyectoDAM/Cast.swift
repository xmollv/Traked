//
//  TraktKeys.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 09/03/16.
//  Copyright © 2016 Xavi. All rights reserved.
//

import Foundation

public class Cast {
	public var character : String?
	public var person : Person?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let cast_list = Cast.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Cast Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Cast]
    {
        var models:[Cast] = []
        for item in array
        {
            models.append(Cast(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let cast = Cast(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Cast Instance.
*/
	required public init?(dictionary: NSDictionary) {

		character = dictionary["character"] as? String
		if (dictionary["person"] != nil) { person = Person(dictionary: dictionary["person"] as! NSDictionary) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.character, forKey: "character")
		dictionary.setValue(self.person?.dictionaryRepresentation(), forKey: "person")

		return dictionary
	}

}