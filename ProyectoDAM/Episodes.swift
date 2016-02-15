//
//  TraktKeys.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 25/01/16.
//  Copyright © 2016 TaniaXavi. All rights reserved.
//

import Foundation

public class Episodes {
	public var season : Int?
	public var number : Int?
	public var title : String?
    public var firstAired : String?
    public var ids : Ids?
    public var number_abs : String?
    public var overview : String?
    public var rating : Double?
    public var votes : Int?
    public var updated_at : String?
    public var images : Images?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let episodes_list = Episodes.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Episodes Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Episodes]
    {
        var models:[Episodes] = []
        for item in array
        {
            models.append(Episodes(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let episodes = Episodes(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Episodes Instance.
*/
	required public init?(dictionary: NSDictionary) {

		season = dictionary["season"] as? Int
		number = dictionary["number"] as? Int
		title = dictionary["title"] as? String
        if (dictionary["first_aired"] != nil) { firstAired = dictionary["first_aired"] as? String }
        if (dictionary["ids"] != nil) { ids = Ids(dictionary: dictionary["ids"] as! NSDictionary) }
        number_abs = dictionary["number_abs"] as? String
        overview = dictionary["overview"] as? String
        rating = dictionary["rating"] as? Double
        votes = dictionary["votes"] as? Int
        updated_at = dictionary["updated_at"] as? String
        if (dictionary["images"] != nil) { images = Images(dictionary: dictionary["images"] as! NSDictionary) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.season, forKey: "season")
		dictionary.setValue(self.number, forKey: "number")
		dictionary.setValue(self.title, forKey: "title")
        dictionary.setValue(self.firstAired, forKey: "first_aired")
		//dictionary.setValue(self.ids?.dictionaryRepresentation(), forKey: "ids")

		return dictionary
	}

}