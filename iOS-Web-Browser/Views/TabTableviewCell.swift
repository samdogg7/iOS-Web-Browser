//
//  TabCollectionViewCell.swift
//  ACME-Web-Browser
//
//  Created by Sam Doggett on 3/24/21.
//

import UIKit

class TabTableviewCell: UITableViewCell {
    //Contains the tab title, as well as delete button
    private lazy var headerStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .lightGray
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "clear"), for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var contentSnapshotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //Delegate to the VC
    var tabViewControllerDelegate: TabViewControllerDelegate?
    //Since the header stack width anchor may change due to auto layout, we must deactivate the old constraint
    private var headerStackWidthAnchor: NSLayoutConstraint?
    private var cellIndex: Int?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(contentSnapshotImageView)
        self.addSubview(headerStack)
        self.addSubview(separator)
        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(deleteButton)
        //This allows the delete button to be pressed without 'selecting' whole cell row
        contentView.isUserInteractionEnabled = false
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        headerStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        //Handle if the width changes, prevent error by disabling previous constraint
        headerStackWidthAnchor?.isActive = false
        headerStackWidthAnchor = headerStack.widthAnchor.constraint(equalToConstant: contentSnapshotImageView.imageSizeAfterAspectFit.width.rounded())
        headerStackWidthAnchor?.isActive = true
        
        headerStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        headerStack.heightAnchor.constraint(equalToConstant: 45).isActive = true

        contentSnapshotImageView.topAnchor.constraint(equalTo: headerStack.bottomAnchor).isActive = true
        contentSnapshotImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentSnapshotImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentSnapshotImageView.bottomAnchor.constraint(equalTo: separator.topAnchor).isActive = true
        
        separator.heightAnchor.constraint(equalToConstant: 2.5).isActive = true
        separator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    //Updates the cell's elements
    func updateCell(cellIndex: Int, title: String, contentSnapshot: UIImage?) {
        self.cellIndex = cellIndex
        titleLabel.text = title
        if let image = contentSnapshot {
            contentSnapshotImageView.image = image
        } else {
            contentSnapshotImageView.image = UIImage(systemName: "globe")
        }
    }
    //Calls delegate to delete tab
    @objc func deletePressed() {
        if let delegate = tabViewControllerDelegate, let index = cellIndex {
            delegate.removeTab(index: index)
        }
    }
}
