//
//  BrowserViewDelegate.swift
//  iOS-Web-Browser
//
//  Created by Sam Doggett on 9/17/21.
//

import UIKit
import WebKit

@objc protocol BrowserViewControllerDelegate: WKNavigationDelegate, UITextFieldDelegate {
    // References from our BrowserView buttons
    @objc func reloadPage()
    @objc func forwardPressed()
    @objc func backPressed()
    @objc func tabPressed()
    @objc func newTabPressed()
    @objc func bookmarksPressed()
    @objc func sharePressed()
    func updateWebViewContent(url: String)
}
