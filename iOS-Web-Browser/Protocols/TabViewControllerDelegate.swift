//
//  TabViewControllerDelegate.swift
//  iOS-Web-Browser
//
//  Created by Sam Doggett on 9/24/21.
//

import Foundation

// MARK: - TabViewControllerDelegate: This delegate communicates to the TabVC to TabTableViewCell
protocol TabViewControllerDelegate {
    func removeTab(index: Int)
}
