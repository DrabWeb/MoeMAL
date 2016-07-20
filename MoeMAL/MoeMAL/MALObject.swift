//
//  MALObject.swift
//  MoeMAL
//
//  Created by Seth on 2016-07-20.
//

import Cocoa
import Alamofire
import SWXMLHash

/// The base class for MAL anime/manga objects
class MALObject {
    /// The URL to this object's image
    var imageUrl : String = "";
    
    /// The title of this object
    var title : String = "";
    
    /// The synopsis of this object
    var synopsis : String = "";
    
    /// Calls the completion handler with a MAL object from the given URL
    func fromUrl(url : String, completionHandler: ((MALObject) -> ())) {
        // Make the request
        Alamofire.request(.GET, url).responseString { responseString in
            
        }
    }
    
    /// Parses the given MAL XML and returns the object that represents it's datas
    func parseXml(xml : XMLIndexer) -> MALObject {
        /// The MAL object to return
        let object : MALObject = MALObject();
        
        // Parse the XML
        print(xml);
        
        // Return the MAL object
        return object;
    }
    
    // Blank init
    init() {
        self.imageUrl = "";
        self.title = "";
        self.synopsis = "";
    }
}