//
//  TraktKeys.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 09/03/16.
//  Copyright © 2016 Xavi. All rights reserved.
//

import Foundation

public class Person {
	public var name : String?
	public var ids : Ids?
	public var images : Images?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let person_list = Person.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Person Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Person]
    {
        var models:[Person] = []
        for item in array
        {
            models.append(Person(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let person = Person(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Person Instance.
*/
	required public init?(dictionary: NSDictionary) {

		name = dictionary["name"] as? String
		if (dictionary["ids"] != nil) { ids = Ids(dictionary: dictionary["ids"] as! NSDictionary) }
		if (dictionary["images"] != nil) { images = Images(dictionary: dictionary["images"] as! NSDictionary) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.name, forKey: "name")
		dictionary.setValue(self.ids?.dictionaryRepresentation(), forKey: "ids")
		dictionary.setValue(self.images?.dictionaryRepresentation(), forKey: "images")

		return dictionary
	}

}