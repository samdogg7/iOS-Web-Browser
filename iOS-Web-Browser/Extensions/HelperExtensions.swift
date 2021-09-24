//
//  HelperExtensions.swift
//  iOS-Web-Browser
// 
//  Created by Sam Doggett on 3/26/21.
// 

import UIKit

extension UIImageView {
    /**
     Credit for the following func: https:// stackoverflow.com/a/14498978
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
        return CGSize(width: newWidth, height: newHeight)
    }
}

// Credit: Stephen Feuerstein
// Source: https:// stephenf.codes/blog/easy-to-use-cell-reuse-extensions

protocol ReusableView {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView { }
extension UICollectionViewCell: ReusableView { }

extension UIActivity.ActivityType {
    static let customActivity = UIActivity.ActivityType("customActivity")
}

extension UIView {
    func roundCorners(_ radius: CGFloat = 15) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func addBorder(width: CGFloat = 1, color: UIColor = .black) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    func addShadow(cornerRadius: CGFloat = 15, shadowColor: UIColor = UIColor(white: 0.0, alpha: 0.5),
                   shadowOffset: CGSize = CGSize(width: 0.0, height: 3.0), shadowOpacity: Float = 0.3,
                   shadowRadius: CGFloat = 5) {
        
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
    func takeScreenshot(size: CGSize) -> UIImage {

        // Begin context
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)

        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
}
