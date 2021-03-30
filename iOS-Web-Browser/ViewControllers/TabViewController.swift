//
//  TabViewController.swift
//  ACME-Web-Browser
//
//  Created by Sam Doggett on 3/24/21.
//

import UIKit

protocol TabViewControllerDelegate {
    func removeTab(index: Int)
}

class TabViewController: UITableViewController {
    private let reuseIdentifier = "TabCell"
    //Manages logic behind the tabs
    private var tabManager: TabManager
    //Parent VC delegate
    private var browserViewControllerDelegate: BrowserViewControllerDelegate

    required init(browserViewControllerDelegate: BrowserViewControllerDelegate, tabManager: TabManager) {
        self.tabManager = tabManager
        self.browserViewControllerDelegate = browserViewControllerDelegate
        super.init(style: .plain)
        
        tableView.register(TabTableviewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorStyle = .none
        self.view.backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabManager.tabs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tabAtIndex = tabManager.tabs[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! TabTableviewCell
        cell.tabViewControllerDelegate = self
        cell.updateCell(cellIndex: indexPath.row, title: "Tab \(indexPath.row + 1)", contentSnapshot: tabAtIndex.contentSnapshot)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Update the tabManagers selected tab
        tabManager.selectedTab = tabManager.tabs[indexPath.row]
        //Update the browser VC's tabManager
        browserViewControllerDelegate.updateTabManager(manager: tabManager)
        //Pop back to the browser VC
        navigationController?.popViewController(animated: true)
    }
}

extension TabViewController: TabViewControllerDelegate {
    //Removes user selected tab
    func removeTab(index: Int) {
        tabManager.tabs.remove(at: index)
        
        //If no tabs remaining, create a new one
        if tabManager.tabs.count == 0 {
            tabManager.newTab()
        }
        
        //If the user removes the currently selected tab, make another tab selected by default
        if index == tabManager.selectedTab.index {
            tabManager.selectedTab = tabManager.tabs.first!
        }
        //Update the browser VC
        browserViewControllerDelegate.updateTabManager(manager: tabManager)
        tableView.reloadData()
    }
}
