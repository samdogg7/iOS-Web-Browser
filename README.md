#  iOS Web Browser README - Sam Doggett

This project demonstrates my iOS development capabilities. The project mimics some of the features of Safari (mobile).

- This project does not use any third party frameworks
- Open from the source folder ~/iOS-Web-Browser/ using Xcode. Press Product > Run to build and run the project

# Coding practices 

Currently I have the most experience with UIKit and prefer to use it programmatically. Storyboard merge conflicts can be difficult to maintain and get complicated as a codebase progresses. My interest in SwiftUI has grown over the past year as Apple continues to release new versions. SwiftUI does not allow for the full flexibility of UIKit; That being said, you can use both in tandem, allowing for a combination of efficient coding (SwiftUI) and maximal configurability (UIKit).

I try to use lazy vars where applicable. This allows for better memory management within the app, as well as allows for closures to adjust an elements properties without cluttering up the class file.

I like to use extensions to separate lifecycle methods from delegate methods or as a means to organize my class file. Class files (particularly view controllers) get out of hand in many code bases. Organizing class files allows for future developers to easily parse through the class and understand its structure.

When passing data from child to parent, I prefer to use delegate methods. This allows for future changes to be tested and refactored with ease.

In conclusion, I stick to practices that value readable, organized, code. 

# Folder structure and contents
```
* indicates not modified

├── README.md - Read more about the project :)
├── iOS-Web-Browser
│   ├── AppDelegate.swift *
│   ├── Info.plist *
│   ├── SceneDelegate.swift                 - Removed main.storyboard, setup initial view controller here
│   ├── Assets.xcassets                     - App Icon
│   ├── Base.lproj *
│   │   └── LaunchScreen.storyboard *
│   ├── DomainExtensions.txt                - List of strings that represent domain extensions (ex: .com, .org, .net)
│   ├── Managers
│   │   └── TabManager.swift                - Manages all of the currently opened tabs
│   ├── Models
│   │   ├── BookmarkActivity.swift          - Custom activity that enables the user to add a bookmark for a given page
│   │   ├── BookmarkedPage.swift            - Bookmark data
│   │   ├── SingleSection.swift             - Section enum for a a single section diffable view
│   │   └── Tab.swift                       - Tab data
│   ├── Protocols
│   │   ├── BrowserViewControllerDelegate.swift     - BrowserView to BrowserViewController communication
│   │   └── TabViewControllerDelegate.swift         - TabViewController to TabTableViewCell communication
│   ├── Extensions
│   │   └── HelperExtensions.swift          - This extension file will allow for easier reuse of common functions
│   ├── ViewControllers
│   │   ├── BookmarksViewController.swift   - The ViewController containing the main browser functionality
│   │   ├── BrowserViewController.swift     - The ViewController for handling Bookmarks
│   │   └── TabViewController.swift         - The ViewController for tab management, allowing users to switch and delete tabs
│   └── Views
│       ├── BookmarkTableViewCell.swift     - Reusable cell used to represent a bookmark
│       ├── BrowserView.swift               - The view for the BrowserViewController
│       └── TabTableViewCell.swift          - Reusable cell used to represent a tab in tab management
```

