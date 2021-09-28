// 
//  Tab.swift
//  iOS-Web-Browser
// 
//  Created by Sam Doggett on 9/19/21.
// 

import UIKit

// MARK: Tab - This model represents a single tab's data
class Tab {
    // Represents the index in terms of tab order
    var index: Int
    // Snapshot image of the last loaded page
    var contentSnapshot: UIImage?
    // Points to the index of the current page (in terms of the history array)
    var historyIndex: Int
    // Contains all of the viewed pages
    var history: [String] = [String]()
    var pageTitle: String = ""
    
    required init(index: Int, homePage: String) {
        self.index = index
        // Add the homepage as the first loaded page
        self.history.append(homePage)
        // Set the history index to 0, the homepage
        self.historyIndex = 0
    }
    
    // Returns the current page url in string form
    func getCurrentPage() -> String {
        return history[historyIndex]
    }
    
    // Returns the current page in url form
    func getCurrentPageUrl() -> URL? {
        return URL(string: history[historyIndex])
    }
    
    // Adds a page to the history array
    func addPageToHistory(url: String) {
        TabManager.shared.selectedTab.history.append(url)
        TabManager.shared.selectedTab.historyIndex += 1
    }
    
    // Shifts the history pointer forward
    func moveForwardHistory() {
        if historyIndex < history.count {
            historyIndex += 1
        }
    }
    
    // Shifts the history pointer backward
    func moveBackHistory() {
        if historyIndex > 0 {
            historyIndex -= 1
        }
    }
    
    // Updates the page title of the site
    func updatePageTitle(_ pageTitle: String?) {
        self.pageTitle = pageTitle ?? history[historyIndex]
    }
}
