// 
//  TabCollectionViewCell.swift
//  iOS-Web-Browser
// 
//  Created by Sam Doggett on 3/24/21.
// 

import UIKit

class TabTableViewCell: UITableViewCell {
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
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
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // Delegate to the VC
    var tabViewControllerDelegate: TabViewControllerDelegate?
    
    private var cellIndex: Int?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(contentSnapshotImageView)
        contentView.addSubview(headerView)
        
        headerView.addSubview(titleLabel)
        headerView.addSubview(deleteButton)
        
        // This allows the delete button to be pressed without 'selecting' whole cell row
        contentView.isUserInteractionEnabled = false
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let tabWidth = (contentSnapshotImageView.image?.size.width ?? 0.0) / 2
        
        headerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        headerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        headerView.widthAnchor.constraint(equalToConstant: tabWidth).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor).isActive = true

        deleteButton.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 40).isActive = true

        contentSnapshotImageView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        contentSnapshotImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        contentSnapshotImageView.widthAnchor.constraint(equalToConstant: tabWidth).isActive = true
        contentSnapshotImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    // Updates the cell's elements
    func updateCell(cellIndex: Int, title: String, contentSnapshot: UIImage?) {
        self.cellIndex = cellIndex
        titleLabel.text = title
        if let image = contentSnapshot {
            contentSnapshotImageView.image = image
        } else {
            contentSnapshotImageView.image = UIImage(systemName: "globe")
        }
    }
    
    // Calls delegate to delete tab
    @objc func deletePressed() {
        if let delegate = tabViewControllerDelegate, let index = cellIndex {
            delegate.removeTab(index: index)
        }
    }
}
