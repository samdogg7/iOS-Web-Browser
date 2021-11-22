// 
//  BrowserTabManager.swift
//  iOS-Web-Browser
// 
//  Created by Sam Doggett on 3/24/21.
// 

import UIKit

/**
    Why did I chose to use a singleton?
    
    Generally it is advised against using singletons. One sacrifices transparency for convenience when using a singleton.
    
    In the case of this project, I chose to use this singleton for two reasons:
    Primarily, I wanted to make sure there was a single instance that was referenced throughout the project.
    Secondarily, I wanted to make the code easy to read for people that are unfamiliar with the project.
 
    Read more in my README.MD
 
 */

// MARK: TabManager - A singleton managing the current tabs throughout the app
@objcMembers class TabManager: NSObject {
    var tabs = [Tab]()
    var selectedTabIndex: Int

    var selectedTab: Tab {
        get {
            return tabs[selectedTabIndex]
        }
    }
    
    // Default page to direct user to
    let homePage = "http://www.google.com/"
    
    // Singleton reference (read above or README.MD)
    static let shared = TabManager()
    
    private override init(){
        let defaultTab = Tab(index: 0, homePage: homePage)
        selectedTabIndex = 0
        tabs.append(defaultTab)
    }
    
    func newTab() {
        // Append the new tab to the end of the tabs array
        let index = tabs.count
        
        let newTab = Tab(index: index, homePage: homePage)
        tabs.append(newTab)
        
        selectedTabIndex = index
    }
}
