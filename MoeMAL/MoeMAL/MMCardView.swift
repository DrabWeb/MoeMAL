//
//  MMCardView.swift
//  MoeMAL
//
//  Created by Seth on 2016-07-21.
//

import Cocoa

class MMCardView: NSView {
    
    /// The background color for this card
    var backgroundColor : NSColor = MMColors.cardColor;

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
        // Set the background color
        self.layer?.backgroundColor = self.backgroundColor.CGColor;
        
        // Set the corner radius
        self.layer?.cornerRadius = 3;
        
        // Setup the shadow
        self.layer?.shadowColor = NSColor.blackColor().CGColor;
        self.layer?.shadowOffset = NSSize(width: 0, height: -1);
        self.layer?.shadowOpacity = 0.4;
        self.layer?.shadowRadius = 2;
    }
}
