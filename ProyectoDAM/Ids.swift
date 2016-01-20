/* 
Copyright (c) 2016 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

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