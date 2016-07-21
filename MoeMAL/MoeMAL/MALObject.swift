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
    
    /// The japanese title of this object
    var japaneseTitle : String = "";
    
    /// The english title of this object(If any)
    var englishTitle : String = "";
    
    /// The synonyms for the title of this object(If any)
    var synonymTitles : String = "";
    
    /// The synopsis of this object
    var synopsis : String = "";
    
    /// Calls the completion handler with a MAL object from the given URL
    func fromUrl(url : String, completionHandler: ((MALObject) -> ())) {
        // Make the request
        Alamofire.request(.GET, url).responseString { responseString in
            do {
                /// The XML for the entire page
                let pageXml : HTMLDocument = try HTMLDocument(string: responseString.result.value!);
                
                // Yes I probably shouldn't do this index chaining for scraping
                
                /// The root XML element that holds all the content we need to parse
                let contentXml : XMLElement = pageXml.body!.children[0].children[3].children[2];
                
                // Parse the content XML, and call the completion handler with the returned object
                completionHandler(self.parseXml(contentXml));
            }
            catch let error as NSError {
                // Print the error to the log
                print("\(self): Error parsing downloaded XML from \(url), \(error.description)");
            }
        }
    }
    
    /// Parses the given MAL XML and returns an object from it
    func parseXml(xml : XMLElement) -> MALObject {
        /// The MAL object to return
        let object : MALObject = MALObject();
        
        // Parse the XML
        
        /// The root XML element that holds the sidebar content
        let sidebarXml : XMLElement = xml.children[1].children[0].children[0].children[0].children[0];
        
        /// The root XML element that holds the inner content(synopsis, characters, ETC.)
        let innerXml : XMLElement = xml.children[1].children[0].children[0].children[1].children[0].children[3].children[0].children[0];
        
        // Set the image URL
        object.imageUrl = sidebarXml.children[0].children[0].children[0].attributes["data-src"]!;
        
        // Set the title
        object.title = xml.children[0].children[1].children[0].stringValue;
        
        // For every element in the sidebar...
        for(_, currentElement) in sidebarXml.children.enumerate() {
            // If the current element is for the japanese title of this object...
            if(currentElement.stringValue.containsString("Japanese: ")) {
                /// This object's japanese title, cleaned
                var cleanedJapaneseTitle : String = currentElement.stringValue;
                
                // Remove new lines
                cleanedJapaneseTitle = cleanedJapaneseTitle.stringByReplacingOccurrencesOfString("\n", withString: "");
                
                /// Remove the "Japanese: " string
                cleanedJapaneseTitle = cleanedJapaneseTitle.stringByReplacingOccurrencesOfString("Japanese: ", withString: "");
                
                // Set the japanese title
                object.japaneseTitle = cleanedJapaneseTitle.withoutExcessWhitespace;
            }
            // If the current element is for the english title of this object...
            else if(currentElement.stringValue.containsString("English: ")) {
                /// This object's english title, cleaned
                var cleanedEnglishTitle : String = currentElement.stringValue;
                
                // Remove new lines
                cleanedEnglishTitle = cleanedEnglishTitle.stringByReplacingOccurrencesOfString("\n", withString: "");
                
                /// Remove the "English: " string
                cleanedEnglishTitle = cleanedEnglishTitle.stringByReplacingOccurrencesOfString("English: ", withString: "");
                
                // Set the english title
                object.englishTitle = cleanedEnglishTitle.withoutExcessWhitespace;
            }
            // If the current element is for the synonym title of this object...
            else if(currentElement.stringValue.containsString("Synonyms: ")) {
                /// This object's synonym title, cleaned
                var cleanedSynonymTitles : String = currentElement.stringValue;
                
                // Remove new lines
                cleanedSynonymTitles = cleanedSynonymTitles.stringByReplacingOccurrencesOfString("\n", withString: "");
                
                /// Remove the "Synonyms: " string
                cleanedSynonymTitles = cleanedSynonymTitles.stringByReplacingOccurrencesOfString("Synonyms: ", withString: "");
                
                // Set the synonym titles
                object.synonymTitles = cleanedSynonymTitles.withoutExcessWhitespace;
            }
        }
        
        // Set the synopsis
        object.synopsis = innerXml.children[2].stringValue;
        
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