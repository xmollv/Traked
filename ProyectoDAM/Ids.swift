//
//  TraktKeys.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 20/01/16.
//  Copyright © 2016 Xavi. All rights reserved.
//

import Foundation

public class Ids {
	public var trakt : Int?
	public var slug : String?
	public var tvdb : Int?
	public var imdb : String?
	public var tmdb : Int?
	public var tvrage : Int?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let ids_list = Ids.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Ids Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Ids]
    {
        var models:[Ids] = []
        for item in array
        {
            models.append(Ids(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let ids = Ids(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Ids Instance.
*/
	required public init?(dictionary: NSDictionary) {

		trakt = dictionary["trakt"] as? Int
		slug = dictionary["slug"] as? String
		tvdb = dictionary["tvdb"] as? Int
		imdb = dictionary["imdb"] as? String
		tmdb = dictionary["tmdb"] as? Int
		tvrage = dictionary["tvrage"] as? Int
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.trakt, forKey: "trakt")
		dictionary.setValue(self.slug, forKey: "slug")
		dictionary.setValue(self.tvdb, forKey: "tvdb")
		dictionary.setValue(self.imdb, forKey: "imdb")
		dictionary.setValue(self.tmdb, forKey: "tmdb")
		dictionary.setValue(self.tvrage, forKey: "tvrage")

		return dictionary
	}

}