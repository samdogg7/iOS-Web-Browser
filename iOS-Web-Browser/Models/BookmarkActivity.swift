//
//  BookmarkActivity.swift
//  iOS-Web-Browser
//
//  Created by Sam Doggett on 9/24/21.
//

import UIKit

// MARK: BookmarkActivity - A custom activity that enables the user to add a bookmark for a given page
class BookmarkActivity: UIActivity {
    // The title of the current page
    var title: String
    // The current url
    var currentUrl: URL
    
    init(title: String, currentUrl: URL) {
        self.title = title
        self.currentUrl = currentUrl
        
        super.init()
    }
    
    override var activityTitle: String? {
        return "Add Bookmark"
    }
    
    override var activityImage: UIImage?{
        return UIImage(systemName: "book")
    }
    
    override class var activityCategory: UIActivity.Category {
        return .action
    }
    
    override var activityType: UIActivity.ActivityType {
        return .customActivity
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
    
    // Saves the bookmark
    override func prepare(withActivityItems activityItems: [Any]) {
        BookmarkedPage(title: title, url: currentUrl).storeBookmark()
    }
}
