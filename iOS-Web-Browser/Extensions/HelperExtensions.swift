//
//  HelperExtensions.swift
//  iOS-Web-Browser
//
//  Created by Sam Doggett on 3/26/21.
//

import UIKit

extension UIImageView {
    /**
     Credit for the following func: https://stackoverflow.com/a/14498978
     I needed a helper function to calculate the size of an image within an ImageView
     after using aspectFit. Rather than making this up myself, I searched stack overflow.
    **/
    var imageSizeAfterAspectFit: CGSize {
        var newWidth: CGFloat
        var newHeight: CGFloat
        
        guard let image = image else { return frame.size }
        
        if image.size.height >= image.size.width {
            newHeight = frame.size.height
            newWidth = ((image.size.width / (image.size.height)) * newHeight)
            
            if CGFloat(newWidth) > (frame.size.width) {
                let diff = (frame.size.width) - newWidth
                newHeight = newHeight + CGFloat(diff) / newHeight * newHeight
                newWidth = frame.size.width
            }
        } else {
            newWidth = frame.size.width
            newHeight = (image.size.height / image.size.width) * newWidth
            
            if newHeight > frame.size.height {
                let diff = Float((frame.size.height) - newHeight)
                newWidth = newWidth + CGFloat(diff) / newWidth * newWidth
                newHeight = frame.size.height
            }
        }
        return .init(width: newWidth, height: newHeight)
    }
}

// Credit: Stephen Feuerstein
// Source: https://stephenf.codes/blog/easy-to-use-cell-reuse-extensions

protocol ReusableView {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView { }
extension UICollectionViewCell: ReusableView { }
