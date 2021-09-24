// 
//  BookmarkedPage.swift
//  iOS-Web-Browser
// 
//  Created by Sam Doggett on 9/19/21.
// 

import Foundation

class BookmarkedPage: Codable, Hashable {
    var title: String
    var url: URL
    
    init(title: String, url: URL) {
        self.title = title
        self.url = url
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(url)
    }

    static func == (lhs: BookmarkedPage, rhs: BookmarkedPage) -> Bool {
        return lhs.title == rhs.title && rhs.url == lhs.url
    }
}
