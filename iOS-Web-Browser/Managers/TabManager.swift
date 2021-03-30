//
//  BrowserTabManager.swift
//  ACME-Web-Browser
//
//  Created by Sam Doggett on 3/24/21.
//

import UIKit

class TabManager {
    var tabs = [Tab]()
    var selectedTab: Tab
    
    required init() {
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
    
    required init(index: Int) {
        self.index = index
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
}
