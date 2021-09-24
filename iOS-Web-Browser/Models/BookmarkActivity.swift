//
//  BookmarkActivity.swift
//  iOS-Web-Browser
//
//  Created by Sam Doggett on 9/24/21.
//

import UIKit

class BookmarkActivity: UIActivity {
    var title: String
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
    
    override func prepare(withActivityItems activityItems: [Any]) {
        let newBookmark = BookmarkedPage(title: title, url: currentUrl)
        
        if let data = UserDefaults.standard.data(forKey: "bookmarks"), var bookmarkedPages = try? JSONDecoder().decode([BookmarkedPage].self, from: data) {
            bookmarkedPages.append(newBookmark)
            let data = try? JSONEncoder().encode(bookmarkedPages)
            UserDefaults.standard.setValue(data, forKey: "bookmarks")
        } else {
            let data = try? JSONEncoder().encode([newBookmark])
            UserDefaults.standard.setValue(data, forKey: "bookmarks")
        }
        
    }
}