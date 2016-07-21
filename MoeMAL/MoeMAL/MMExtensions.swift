//
//  MMExtensions.swift
//  MoeMAL
//
//  Created by Seth on 2016-07-21.
//

import Cocoa

extension String {
    /// Returns this string without excess whitespace
    var withoutExcessWhitespace: String {
        /// The components of this string separated by whitespace
        let components = self.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet());
        
        /// The components, filtered
        let filtered = components.filter({!$0.isEmpty});
        
        /// Return the filtered components joined by spaces
        return filtered.joinWithSeparator(" ");
    }
}