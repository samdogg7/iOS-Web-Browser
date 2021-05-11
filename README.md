#  iOS Web Browser README - Sam Doggett

This project demonstrates my iOS development capabilities. The project mimics some of the basic features of Safari (mobile). I worked roughly 5-6 hours on this project for reference.

# Coding practices 

Currently I have the most experience with UIKit and prefer to use it programmatically. Storyboard merge conflicts can be difficult to maintain and get complicated as a codebase progresses. My interest in SwiftUI has grown over the past year as Apple continues to release new versions. SwiftUI does not allow for the full flexibility of UIKit; That being said, you can use both in tandem, allowing for a combination of efficient coding (SwiftUI) and maximal configurability (UIKit).

    - I try to use lazy vars where applicable. This allows for better memory management within the app, as well as allows for closures to adjust an elements properties without cluttering up the class file.
    - I like to use extensions to separate lifecycle methods from delegate methods or as a means to organize my class file. Class files (particularly view controllers) get out of hand in many code bases. Organizing class files allows for future developers to easily parse through the class and understand its structure.
    - When passing data from child to parent, I prefer to use delegate methods. This allows for future changes to be tested and refactored with ease.

In conclusion, I stick to practices that value readable, organized, code. 

# Folder structure and contents
```
* indicates not modified

iOS-Web-Browser
| AppDelegate.swift *
| SceneDelegate.swift *
| Assets.xcassets *
| LaunchScreen.storyboard *
| Info.plist *
| DomainExtensions.txt              - List of strings that represent domain extensions (ex: .com, .org, .net)
| README.md                         - Read more about the project :)
| Main.storyboard                   - Setup navigation controller + set up BrowserViewController as root VC.
|
|---ViewControllers                 - Contains view controllers used in the project
|   | BrowserViewController.swift   - BrowserViewController is the main VC representing the browser
|   | TabViewController.swift       - TabViewController is the VC for tab management, allowing users to switch and delete tabs
|   
|---Views                           - Contains custom views   
|   | TabTableviewCell.swift        - TabTableViewCell is the reusable cell used to represent a tab in tab management
|   
|---Managers                        - Contains the logic based classes that are not VC's
|   | TabManager                    - TabManager handles the logic behind the tab management of a user
|
|---Extensions                      - Extensions
|   | HelperExtensions              - This extension file will allow for easier reuse of common functions
```
