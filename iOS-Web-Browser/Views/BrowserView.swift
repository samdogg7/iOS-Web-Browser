//
//  BrowserView.swift
//  iOS-Web-Browser
//
//  Created by Sam Doggett on 9/17/21.
//

import WebKit
import UIKit

class BrowserView: UIView {
    //Displays web content
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()
    //User input field for the search they are executing
    lazy var urlTextField: UITextField = {
        let textField = UITextField()
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
     lazy var reloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.clockwise.circle"), for: .normal)
        button.addTarget(delegate, action: #selector(delegate?.reloadPage), for: .touchUpInside)
        return button
    }()
    //A stack that is similar to a tab bar, but with a little more control (and ease)
     lazy var bottomBarStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        return stack
    }()
    //Moves the user forward in their history
     lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.addTarget(delegate, action: #selector(delegate?.forwardPressed), for: .touchUpInside)
        return button
    }()
    //Moves the user backward in their history
     lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.addTarget(delegate, action: #selector(delegate?.backPressed), for: .touchUpInside)
        return button
    }()
    //Pushes the tab management VC to navigation stack
     lazy var tabButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.on.square"), for: .normal)
        button.addTarget(delegate, action: #selector(delegate?.tabPressed), for: .touchUpInside)
        return button
    }()
    //Shares current page
     lazy var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.addTarget(delegate, action: #selector(delegate?.sharePressed), for: .touchUpInside)
        return button
    }()
    //Presents bookmarks view controller
     lazy var bookmarksButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "book"), for: .normal)
        button.addTarget(delegate, action: #selector(delegate?.bookmarksPressed), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: BrowserViewControllerDelegate? {
        didSet {
            webView.navigationDelegate = delegate
            urlTextField.delegate = delegate
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Adds subviews and arranged subviews to their parents
    private func setupViews() {
        self.addSubview(urlTextField)
        self.addSubview(webView)
        self.addSubview(bottomBarStack)
        
        bottomBarStack.addArrangedSubview(backButton)
        bottomBarStack.addArrangedSubview(forwardButton)
        bottomBarStack.addArrangedSubview(shareButton)
        bottomBarStack.addArrangedSubview(bookmarksButton)
        bottomBarStack.addArrangedSubview(tabButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        urlTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        urlTextField.bottomAnchor.constraint(equalTo: webView.topAnchor).isActive = true
        urlTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        urlTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        urlTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        urlTextField.layer.cornerRadius = 5
        urlTextField.layer.borderWidth = 1
        urlTextField.layer.borderColor = UIColor.black.cgColor
        
        webView.bottomAnchor.constraint(equalTo: bottomBarStack.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        bottomBarStack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomBarStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        bottomBarStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        bottomBarStack.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
