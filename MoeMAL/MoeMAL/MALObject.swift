//
//  MALObject.swift
//  MoeMAL
//
//  Created by Seth on 2016-07-20.
//

import Cocoa
import Alamofire
import Fuzi

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
            do {
                /// The XML for the entire page
                let pageXml : HTMLDocument = try HTMLDocument(string: responseString.result.value!);
                
                // Yes I probably shouldn't do this index chain for getting the content div
                /// The XML of the content tr element
                let contentXml : XMLElement = pageXml.body!.children[0].children[3].children[2].children[1].children[0].children[0];
                
                // Parse the content XML
                self.parseXml(contentXml);
            }
            catch let error as NSError {
                // Print the error to the log
                print("\(self): Error parsing downloaded XML from \(url), \(error.description)");
            }
        }
    }
    
    /// Parses the given MAL XML(Passed the tr that holds the actual content) and returns an object from it
    func parseXml(xml : XMLElement) -> MALObject {
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