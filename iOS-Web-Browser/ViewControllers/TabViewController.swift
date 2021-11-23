// 
//  TabViewController.swift
//  iOS-Web-Browser
// 
//  Created by Sam Doggett on 3/24/21.
// 

import UIKit

// MARK: - TabViewController: This VC manages the open tabs
class TabViewController: UITableViewController {
    // Creates a new tab
     private lazy var newTabButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: delegate, action: #selector(delegate?.newTabPressed))
        return button
    }()
    
    // Parent VC delegate
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
}

// All tableView related delegate overrides
extension TabViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.tabManager.tabs.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tabAtIndex = delegate?.tabManager.tabs[indexPath.row] else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TabTableViewCell.reuseIdentifier) as! TabTableViewCell
        cell.tabViewControllerDelegate = self
        cell.updateCell(cellIndex: indexPath.row, title: tabAtIndex.pageTitle, contentSnapshot: tabAtIndex.contentSnapshot)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Update the tabManagers selected tab
        delegate?.tabManager.selectedTabIndex = indexPath.row
        delegate?.reloadPage()
        // Pop back to the browser VC
        navigationController?.popViewController(animated: true)
    }
}

extension TabViewController: TabViewControllerDelegate {
    // Removes user selected tab
    func removeTab(index: Int) {
        delegate?.tabManager.tabs.remove(at: index)
        
        // If no tabs remaining, create a new one
        if delegate?.tabManager.tabs.count == 0 {
            delegate?.tabManager.newTab()
            delegate?.reloadPage()
        }
        
        // If the user removes the currently selected tab, make the first tab selected by default
        if index == delegate?.tabManager.selectedTab.index {
            delegate?.tabManager.selectedTabIndex = 0
            delegate?.reloadPage()
        }
        tableView.reloadData()
    }
}
