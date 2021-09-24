// 
//  Tab.swift
//  iOS-Web-Browser
// 
//  Created by Sam Doggett on 9/19/21.
// 

import UIKit

class Tab {
    var index: Int
    var contentSnapshot: UIImage?
    var historyIndex = 0
    var history: [String] =  [ "https://www.google.com/" ]
    var pageTitle: String
    
    required init(index: Int) {
        self.index = index
        self.pageTitle = history[historyIndex]
    }
    
    func getCurrentPage() -> String {
        return history[historyIndex]
    }
    
    func addPageToHistory(url: String) {
        TabManager.shared.selectedTab.history.append(url)
        TabManager.shared.selectedTab.historyIndex += 1
    }
    
    func moveForwardHistory() {
        if historyIndex < history.count {
            historyIndex += 1
        }
    }
    
    func moveBackHistory() {
        if historyIndex > 0 {
            historyIndex -= 1
        }
    }
    
    func updatePageTitle(_ pageTitle: String?) {
        self.pageTitle = pageTitle ?? history[historyIndex]
    }
    
    func getCurrentPageUrl() -> URL? {
        return URL(string: history[historyIndex])
    }
}
