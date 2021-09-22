//
//  BookmarksViewController.swift
//  iOS-Web-Browser
//
//  Created by Sam Doggett on 9/17/21.
//

import UIKit

typealias DataSource = UITableViewDiffableDataSource<SingleSection, BookmarkedPage>
typealias Snapshot = NSDiffableDataSourceSnapshot<SingleSection, BookmarkedPage>

class BookmarksViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(BookmarkTableViewCell.self, forCellReuseIdentifier: BookmarkTableViewCell.reuseIdentifier)
        table.separatorStyle = .none
        table.delegate = self
        return table
    }()
    
    private lazy var dataSource = makeDataSource()
    
    private lazy var bookmarks: [BookmarkedPage] = {
        if let data = UserDefaults.standard.data(forKey: "bookmarks"), let bookmarks = try? JSONDecoder().decode([BookmarkedPage].self, from: data) {
            return bookmarks
        }
        return [BookmarkedPage]()
    }()
    
    weak var delegate: BrowserViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Favorites"
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        applySnapshot()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        tableView.dataSource = dataSource
    }
    
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, bookmark) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkTableViewCell.reuseIdentifier, for: indexPath) as? BookmarkTableViewCell
            cell?.populateCell(bookmark)
            return cell
        })
        return dataSource
    }
    
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(SingleSection.allCases)
        snapshot.appendItems(bookmarks)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

extension BookmarksViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TabManager.shared.tabs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let bookmark = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        // Loads selected bookmark
        delegate?.updateWebViewContent(url: bookmark.url.absoluteString)
        
        // Adds selected page to history
        TabManager.shared.selectedTab.addPageToHistory(url: bookmark.url.absoluteString)
        
        //Pop back to the browser VC
        navigationController?.popViewController(animated: true)
    }
}
