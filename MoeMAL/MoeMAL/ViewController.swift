//
//  ViewController.swift
//  MoeMAL
//
//  Created by Seth on 2016-07-19.
//

import Cocoa

class ViewController: NSViewController {
    
    /// The main window of this view controller
    var window : NSWindow = NSWindow();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        // Style the window
        styleWindow();
        
        // Load an example anime
        MALAnime().fromUrl("http://myanimelist.net/anime/32664/", completionHandler: objectLoaded);
        MALAnime().fromUrl("http://myanimelist.net/anime/32828/Amaama_to_Inazuma", completionHandler: objectLoaded);
        MALAnime().fromUrl("http://myanimelist.net/manga/32833/Himegoto", completionHandler: objectLoaded);
    }
    
    func objectLoaded(object : MALObject) {
        print("\(object.imageUrl)");
        print("\(object.title)(\(object.japaneseTitle))(\(object.englishTitle))(\(object.synonymTitles))");
        print("\(object.synopsis)");
        print("");
    }
    
    /// Styles the window
    func styleWindow() {
        // Get the window
        window = NSApplication.sharedApplication().windows.last!;
        
        // Style the window
        window.titleVisibility = .Hidden;
        window.titlebarAppearsTransparent = true;
        window.standardWindowButton(.CloseButton)?.superview?.layer?.backgroundColor = MMColors.titlebarColor.CGColor;
        window.backgroundColor = MMColors.windowBackgroundColor;
    }
}