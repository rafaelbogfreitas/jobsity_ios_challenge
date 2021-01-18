# 🖥 Jobsity Code Challenge 💻

## Purpose

App developed to fullfil the specs of Jobsity's iOS code challenge. It consists of an tv series and actors list application on which you can find people and TV show, read information about them and find out details about the episodes. You can also make shows as favorites to keep a list of all you have chosen.

## Specs

| Mandatory Features       | Completion | 
| --------------------------- |:--------------:| 
|     List series with API    |          ✅        |
|     Serie details page      |          ✅        |
|     List of episodes         |          ✅        |
|     Episode details          |          ✅        |
|     Series search             |          ✅        |

| Bonus Features              | Completion | 
| --------------------------- |:--------------:| 
|     People search            |          ✅        |
|     People details             |          ✅        |
|     Favorite series            |          ✅        |
|     Delete Favorites         |          ✅        |
|     Favorite details          |          ✅        |
|     Pin                              |          🔜        |
|     Fingerprint                  |          🔜        |

## Screenshots

###Dark mode

![app dark mode](https://media.giphy.com/media/KcdBFweSn76HcNQAHe/giphy.gif)

###Light mode

![app dark mode](https://media.giphy.com/media/EAOaXKDwhfLLdXTj62/giphy.gif)


## Installation

After cloning the repository and navigate to the project's folder where a **Podfile** is located. If you don't have **cocoapods** installed in your machine, run the following command:

```Bash
sudo gem install cocoapods
```

In case something doesn't work out as expected, follow the link bellow on  [Getting started with Cocoapods](https://guides.cocoapods.org/using/getting-started.html) 

---
After installing **cocoapods** run the command bellow in the project's root to install the its dependencies:

```Bash
pod install
```
After installing all libraries open the workspace on **xCode** and it will be ready to buil and run.

## Libraries

[SnapKit](https://github.com/SnapKit/SnapKit)

Used to help wrinting constraints for the UI elements

[Realm](https://realm.io/docs/swift/latest/)

Local database, used to save and persist user's favorite series

[Kingfisher](https://github.com/onevcat/Kingfisher)

Fetch images from url and cache them

[Kingfisher](https://github.com/onevcat/Kingfisher)

Fetch images from url and cache them

[Alamofire](https://github.com/Alamofire/Alamofire)

Perform HTTP requests

[SwiftLint](https://github.com/realm/SwiftLint)

Linter with Realm specs based on CleanCode Architecture

