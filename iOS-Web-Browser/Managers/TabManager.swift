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
