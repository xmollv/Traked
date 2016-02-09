//
//  TraktKeys.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 20/01/16.
//  Copyright © 2016 TaniaXavi. All rights reserved.
//

import Foundation

public class ShowOrMovie {
	public var title : String?
	public var year : Int?
	public var ids : Ids?
	public var images : Images?
    public var seasons : Array<Seasons>?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let show_list = Show.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Show Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [ShowOrMovie]
    {
        var models:[ShowOrMovie] = []
        for item in array
        {
            models.append(ShowOrMovie(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let show = Show(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Show Instance.
*/
	required public init?(dictionary: NSDictionary) {

		title = dictionary["title"] as? String
		year = dictionary["year"] as? Int
		if (dictionary["ids"] != nil) { ids = Ids(dictionary: dictionary["ids"] as! NSDictionary) }
		if (dictionary["images"] != nil) { images = Images(dictionary: dictionary["images"] as! NSDictionary) }
        seasons = [Seasons]()
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.title, forKey: "title")
		dictionary.setValue(self.year, forKey: "year")
		dictionary.setValue(self.ids?.dictionaryRepresentation(), forKey: "ids")
		dictionary.setValue(self.images?.dictionaryRepresentation(), forKey: "images")

		return dictionary
	}

}