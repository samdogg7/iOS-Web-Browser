//
//  TabViewController.swift
//  iOS-Web-Browser
//
//  Created by Sam Doggett on 3/24/21.
//

import UIKit

protocol TabViewControllerDelegate {
    func removeTab(index: Int)
}

class TabViewController: UITableViewController {
    //Creates a new tab
     private lazy var newTabButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: delegate, action: #selector(delegate?.newTabPressed))
        return button
    }()
    
    //Parent VC delegate
    weak var delegate: BrowserViewControllerDelegate? {
        didSet {
            navigationItem.rightBarButtonItem = newTabButton
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TabTableViewCell.self, forCellReuseIdentifier: TabTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        view.backgroundColor = .gray
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TabManager.shared.tabs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tabAtIndex = TabManager.shared.tabs[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TabTableViewCell.reuseIdentifier) as! TabTableViewCell
        cell.tabViewControllerDelegate = self
        cell.updateCell(cellIndex: indexPath.row, title: tabAtIndex.pageTitle, contentSnapshot: tabAtIndex.contentSnapshot)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Update the tabManagers selected tab
        TabManager.shared.selectedTab = TabManager.shared.tabs[indexPath.row]
        delegate?.reloadPage()
        //Pop back to the browser VC
        navigationController?.popViewController(animated: true)
    }
}

extension TabViewController: TabViewControllerDelegate {
    //Removes user selected tab
    func removeTab(index: Int) {
        TabManager.shared.tabs.remove(at: index)
        
        //If no tabs remaining, create a new one
        if TabManager.shared.tabs.count == 0 {
            TabManager.shared.newTab()
            delegate?.reloadPage()
        }
        
        //If the user removes the currently selected tab, make another tab selected by default
        if index == TabManager.shared.selectedTab.index {
            TabManager.shared.selectedTab = TabManager.shared.tabs.first!
            delegate?.reloadPage()
        }
        tableView.reloadData()
    }
}
