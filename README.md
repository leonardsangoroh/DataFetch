# Data Fetch
A Data Fetch project aimed at practising intermediate Swift concepts. The project takes a data feed from a website
and parses it into useful information for users. 

## Technologies
Native application developed using Swift programming language.

### Below are the Swift concepts applied in this project
- UITabBarController
- UINavigationController
- Codable
- Unwrapping
- URL
- WKWebView
- didSelectRowAt
- UIAlertController

### Other Concept(s)
- JSON (JavaScript Object Notation)

### Setting Up Tab Bar
- First embed Navigation Controller to the View Controller
- Then embed the Tab Bar Controller
- Add the following piece of code to the Scene Delegate
```
if let tabBarController = window?.rootViewController as? UITabBarController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "NavController")
    vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
    tabBarController.viewControllers?.append(vc)
}
```
## App Screenshot(s)

#### Screenshot 1 (Most Recent View)
<img width="385" alt="Screenshot 2024-03-03 at 11 09 05" src="https://github.com/leonardsangoroh/DataFetch/assets/61079370/27288e7c-f875-4bb3-93e0-daf3beee21a6">

#### Screenshot 2 (Top Rated View)
<img width="385" alt="Screenshot 2024-03-03 at 11 09 15" src="https://github.com/leonardsangoroh/DataFetch/assets/61079370/c12fe0ae-70c8-4837-b74f-4e5ec7533288">

#### Screenshot 3 (Search UIAlert)
<img width="385" alt="Screenshot 2024-03-03 at 11 09 23" src="https://github.com/leonardsangoroh/DataFetch/assets/61079370/135f3b2f-45c6-4442-bf90-d5382c036dc1">

#### Screenshot 4 (Info UIAlert)
<img width="385" alt="Screenshot 2024-03-03 at 11 10 01" src="https://github.com/leonardsangoroh/DataFetch/assets/61079370/88d455ac-0ffc-44ac-808a-fd14c9dc6b05">

## Show your support
Give a ⭐️ if you like this project!

## Acknowledgments
- Paul Hudson - the lead instructor of the 100 days of Swift course

## License
N/A
