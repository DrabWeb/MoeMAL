//
//  MALAnime.swift
//  MoeMAL
//
//  Created by Seth on 2016-07-20.
//

import Cocoa

/// The object that represents an anime on MAL
class MALAnime: MALObject {
    /// Calls the completion handler with a MAL anime object from the given URL
    override func fromUrl(url : String, completionHandler: ((MALAnime) -> ())) {
        super.fromUrl(url, completionHandler: { object in
            print(object);
        });
    }
    
    // Blank init
    override init() {
        super.init();
    }
    
    // Init with all the values from a MALObject
    init(object : MALObject) {
        super.init();
        
        self.imageUrl = object.imageUrl;
        self.title = object.title;
        self.synopsis = object.synopsis;
    }
}