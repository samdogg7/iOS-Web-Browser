#  ACME Web Browser README - Sam Doggett

Thank you for extending the opportunity to demonstrate my mobile development talents in the form of a project. This was a fun assignment!

I spent ~5 hours working on this assignment for transparency. If I had more time I would prioritize adding a regex to the user input field, to handle more complex requests, as well as adding data storage so we can persistently save tabs and their histories. I would also like to polish up the user interface/experience by adding support for gestures (such as swiping to delete a tab or moving forward/back a page). Finally I would like to improve the overall aesthetic of the application to give a more crisp user experience. These were ice boxed solely due to the constraint of time.

I approached this project initially by finding inspiration from other competing mobile browsers. In order to deliver a user experience that does not require a lot of guidance, I hoped to find a familiar design. This includes identifiable button icons used by native iOS applications. The primary use case of a browser is it's ability to browse the web, so I focused on making a design that maximized the size of the web content. 

# How to build and run the project

- This project does not use any third party frameworks
- Open from the source folder ~/ACME-Web-Browser/ using Xcode. Press Product > Run to build and run the project

# Coding practices 

Currently I have the most experience with UIKit and prefer to use it programmatically. Storyboard merge conflicts can be difficult to maintain and get complicated as a codebase progresses. My interest in SwiftUI has grown over the past year as Apple continues to release new versions. SwiftUI does not allow for the full flexibility of UIKit; That being said, you can use both in tandem, allowing for a combination of efficient coding (SwiftUI) and maximal configurability (UIKit). Currently, I have made a few SwiftUI demo projects, but I want to gain more experience with SwiftUI before sharing!

    - I try to use lazy vars where applicable. This allows for better memory management within the app, as well as allows for closures to adjust an elements properties without cluttering up the class file.
    - I like to use extensions to separate lifecycle methods from delegate methods or as a means to organize my class file. Class files (particularly view controllers) get out of hand in many code bases. Organizing class files allows for future developers to easily parse through the class and understand its structure.
    - When passing data from child to parent, I prefer to use delegate methods. This allows for future changes to be tested and refactored with ease.

In conclusion, I stick to practices that value readable, organized, code. 

# Folder structure and contents
```
* indicates not modified

ACME-Web-Browser
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
