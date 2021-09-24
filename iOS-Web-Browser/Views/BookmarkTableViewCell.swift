// 
//  BookmarkTableViewCell.swift
//  iOS-Web-Browser
// 
//  Created by Sam Doggett on 9/19/21.
// 

import UIKit

class BookmarkTableViewCell: UITableViewCell {
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var chevronImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var bookmarkedPage: BookmarkedPage?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(mainStack)
        
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(chevronImageView)
        
        contentView.addShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    func populateCell(_ bookmarkedPage: BookmarkedPage) {
        titleLabel.text = bookmarkedPage.title
        self.bookmarkedPage = bookmarkedPage
    }
}
