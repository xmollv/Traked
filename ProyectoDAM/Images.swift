//
//  TraktKeys.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 20/01/16.
//  Copyright © 2016 TaniaXavi. All rights reserved.
//

import Foundation

public class Images {
	public var fanart : Fanart?
	public var poster : Poster?
	public var logo : Logo?
	public var clearart : Clearart?
	public var banner : Banner?
	public var thumb : Thumb?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let images_list = Images.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Images Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Images]
    {
        var models:[Images] = []
        for item in array
        {
            models.append(Images(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let images = Images(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Images Instance.
*/
	required public init?(dictionary: NSDictionary) {

		if (dictionary["fanart"] != nil) { fanart = Fanart(dictionary: dictionary["fanart"] as! NSDictionary) }
		if (dictionary["poster"] != nil) { poster = Poster(dictionary: dictionary["poster"] as! NSDictionary) }
		if (dictionary["logo"] != nil) { logo = Logo(dictionary: dictionary["logo"] as! NSDictionary) }
		if (dictionary["clearart"] != nil) { clearart = Clearart(dictionary: dictionary["clearart"] as! NSDictionary) }
		if (dictionary["banner"] != nil) { banner = Banner(dictionary: dictionary["banner"] as! NSDictionary) }
		if (dictionary["thumb"] != nil) { thumb = Thumb(dictionary: dictionary["thumb"] as! NSDictionary) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.fanart?.dictionaryRepresentation(), forKey: "fanart")
		dictionary.setValue(self.poster?.dictionaryRepresentation(), forKey: "poster")
		dictionary.setValue(self.logo?.dictionaryRepresentation(), forKey: "logo")
		dictionary.setValue(self.clearart?.dictionaryRepresentation(), forKey: "clearart")
		dictionary.setValue(self.banner?.dictionaryRepresentation(), forKey: "banner")
		dictionary.setValue(self.thumb?.dictionaryRepresentation(), forKey: "thumb")

		return dictionary
	}

}