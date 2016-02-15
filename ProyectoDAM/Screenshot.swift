//
//  TraktKeys.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 15/02/16.
//  Copyright © 2016 TaniaXavi. All rights reserved.
//

import Foundation

public class Screenshot {
	public var full : String?
	public var medium : String?
	public var thumb : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let screenshot_list = Screenshot.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Screenshot Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Screenshot]
    {
        var models:[Screenshot] = []
        for item in array
        {
            models.append(Screenshot(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let screenshot = Screenshot(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Screenshot Instance.
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