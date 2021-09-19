//
//  BrowserTabManager.swift
//  iOS-Web-Browser
//
//  Created by Sam Doggett on 3/24/21.
//

import UIKit

@objcMembers class TabManager: NSObject {
    var tabs = [Tab]()
    var selectedTab: Tab
    
    static let shared = TabManager()
    
    private override init(){
        selectedTab = Tab(index: 0)
        tabs.append(selectedTab)
    }
    
    func newTab() {
        let newTab = Tab(index: tabs.count)
        selectedTab = newTab
        tabs.append(newTab)
    }
}

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
}
