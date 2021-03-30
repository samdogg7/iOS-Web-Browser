//
//  ViewController.swift
//  ACME-Web-Browser
//
//  Created by Sam Doggett on 3/23/21.
//

import UIKit
import WebKit

protocol BrowserViewControllerDelegate {
    func updateTabManager(manager: TabManager)
}

class BrowserViewController: UIViewController {
    //Keeps track of all the open tabs and their histories
    private lazy var tabManager : TabManager = {
        return TabManager()
    }()
    //Displays web content
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()
    //User input field for the search they are executing
    private lazy var urlTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(red: 245, green: 245, blue: 245, alpha: 90)
        textField.rightView = reloadButton
        textField.rightViewMode = .always
        textField.returnKeyType = .search
        
        //Add a 10pts of padding to left side of textfield
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 1.0))
        textField.leftViewMode = .always
        
        return textField
    }()
    //Reloads the current page
    private lazy var reloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.clockwise.circle"), for: .normal)
        button.addTarget(self, action: #selector(reloadPage), for: .touchUpInside)
        return button
    }()
    //A stack that is similar to a tab bar, but with a little more control (and ease)
    private lazy var bottomBarStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    //A stack to pair the back/forward history buttons together
    private lazy var historyButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        return stack
    }()
    //Moves the user forward in their history
    private lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.addTarget(self, action: #selector(forwardPressed), for: .touchUpInside)
        return button
    }()
    //Moves the user backward in their history
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        return button
    }()
    //Pushes the tab management VC to navigation stack
    private lazy var tabButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.on.square"), for: .normal)
        button.addTarget(self, action: #selector(tabPressed), for: .touchUpInside)
        return button
    }()
    //Creates a new tab
    private lazy var newTabButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus.app"), for: .normal)
        button.addTarget(self, action: #selector(newTabPressed), for: .touchUpInside)
        return button
    }()
    //An array of domain extensions used to deduce if a user is searching for specific url or wants to search by keyword
    private lazy var domainExtensions: [String] = {
        if let path = Bundle.main.path(forResource: "DomainExtensions", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                return data.components(separatedBy: .newlines).map { $0.lowercased() }
            } catch {
                print(error)
            }
        }
        return [ ".com", ".net", ".org", ".co" ]
    }()
    
    private let homePageUrl = "http://www.google.com/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load the default url
        if let url = URL(string: tabManager.selectedTab.getCurrentPage()) {
            urlTextField.text = url.absoluteString
            webView.load(URLRequest(url: url))
        }
        //Setup views
        setupViews()
    }
    //When this view controller is presented, hide the nav bar to maximize screen real estate
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    //When this view controller disappears, enable the navigation bar
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Check if the back button should be enabled or not (when on new tab, shouldn't be able to go back)
        if tabManager.selectedTab.history.count == 1 || tabManager.selectedTab.historyIndex == 0 {
            backButton.isEnabled = false
        } else {
            backButton.isEnabled = true
        }
        //Check if the forward button should be enabled or not (when on most recent page, shouldn't be able to go forward)
        if tabManager.selectedTab.history.count - 1 == tabManager.selectedTab.historyIndex {
            forwardButton.isEnabled = false
        } else {
            forwardButton.isEnabled = true
        }
        
        urlTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        urlTextField.bottomAnchor.constraint(equalTo: webView.topAnchor).isActive = true
        urlTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        urlTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        urlTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        urlTextField.layer.cornerRadius = 5
        urlTextField.layer.borderWidth = 1
        urlTextField.layer.borderColor = UIColor.black.cgColor
        
        webView.bottomAnchor.constraint(equalTo: bottomBarStack.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        bottomBarStack.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomBarStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        bottomBarStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        bottomBarStack.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        historyButtonStack.widthAnchor.constraint(equalToConstant: 75).isActive = true
        newTabButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    //Adds subviews and arranged subviews to their parents
    private func setupViews() {
        view.addSubview(urlTextField)
        view.addSubview(webView)
        view.addSubview(bottomBarStack)
        
        bottomBarStack.addArrangedSubview(historyButtonStack)
        bottomBarStack.addArrangedSubview(newTabButton)
        bottomBarStack.addArrangedSubview(tabButton)
        
        historyButtonStack.addArrangedSubview(backButton)
        historyButtonStack.addArrangedSubview(forwardButton)
    }
    
    //Updates webView's content and updates the user input textfield
    func updateWebViewContent(url: String) {
        if let url = URL(string: url) {
            webView.load(URLRequest(url: url))
        } else {
            webView.load(URLRequest(url: URL(string: homePageUrl)!))
        }
        urlTextField.text = url
    }
}

//MARK: - BrowserViewControllerDelegate methods, used to update the tab manager after changes
extension BrowserViewController: BrowserViewControllerDelegate {
    //This method will be called from the tab manager, updating the current tabs
    func updateTabManager(manager: TabManager) {
        //Update this VC's tabManager
        self.tabManager = manager
        reloadPage()
    }
}

//MARK: - All functions regarding button presses
extension BrowserViewController {
    //Reloads the current page
    @objc func reloadPage() {
        updateWebViewContent(url: tabManager.selectedTab.getCurrentPage())
    }
    //Moves forward in the history stack
    @objc func forwardPressed() {
        tabManager.selectedTab.moveForwardHistory()
        updateWebViewContent(url: tabManager.selectedTab.getCurrentPage())
    }
    //Moves backward in the history stack
    @objc func backPressed() {
        tabManager.selectedTab.moveBackHistory()
        updateWebViewContent(url: tabManager.selectedTab.getCurrentPage())
    }
    //Tab manager VC is opened
    @objc func tabPressed() {
        let vc = TabViewController(browserViewControllerDelegate: self, tabManager: self.tabManager)
        navigationController?.pushViewController(vc, animated: true)
    }
    //New tab is added
    @objc func newTabPressed() {
        tabManager.newTab()
        reloadPage()
    }
}

//MARK: - WKNavigationDelegate methods
extension BrowserViewController: WKNavigationDelegate {
    //Check if the user navigated to a new page from within the webView content (not search bar)
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        let currentPage = tabManager.selectedTab.getCurrentPage()
        
        if let url = webView.url?.absoluteString, url != currentPage {
            print("User navigated from \(url) to \(currentPage)")
            tabManager.selectedTab.history.append(url)
            tabManager.selectedTab.historyIndex += 1
            urlTextField.text = url
        }
    }
    //Each time a page is done loading, add a snapshot of the content to the tab manager
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if #available(iOS 11.0, *) {
            webView.takeSnapshot(with: nil, completionHandler: { (image, error) in
                if let snapshotImage = image {
                    self.tabManager.selectedTab.contentSnapshot = snapshotImage
                }
            })
        }
    }
}

//MARK: - UITextFieldDelegate methods
extension BrowserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let url = textField.text {
            var formattedURL = url.lowercased()
            
            //If I were to work on this project longer, I would make a robust Regex to handle user input
            
            //If there is no user input, direct to the home page
            if url == "" {
                formattedURL = homePageUrl
            //If the url does not appear to be a valid web address
            } else if !url.contains("https://") && !url.contains("www.") {
                //Check if it was meant to be a valid address (if user did not add https:// or www.) check if it contains a domain extension
                if let pathExtension = URL(string: url)?.pathExtension, pathExtension != "", domainExtensions.contains(pathExtension) {
                    formattedURL = "https://\(formattedURL)"
                //Presumed the user wanted to search a keyword
                } else {
                    formattedURL = "http://www.google.com/search?q=\(formattedURL.replacingOccurrences(of: " ", with: "+"))"
                }
            }
            //Make sure all urls end in a '/'
            if !formattedURL.hasSuffix("/") {
                formattedURL = "\(formattedURL)/"
            }
            //Add new search to history
            tabManager.selectedTab.history.append(formattedURL)
            tabManager.selectedTab.historyIndex += 1
            //Update web view
            updateWebViewContent(url: formattedURL)
            //Hide keyboard
            urlTextField.resignFirstResponder()
        }
        return true
    }
}
