# HBStatusBarNotification

[![CI Status](http://img.shields.io/travis/havenbarnes/HBStatusBarNotification.svg?style=flat)](https://travis-ci.org/havenbarnes/HBStatusBarNotification)
[![Version](https://img.shields.io/cocoapods/v/HBStatusBarNotification.svg?style=flat)](http://cocoapods.org/pods/HBStatusBarNotification)
[![License](https://img.shields.io/cocoapods/l/HBStatusBarNotification.svg?style=flat)](http://cocoapods.org/pods/HBStatusBarNotification)
[![Platform](https://img.shields.io/cocoapods/p/HBStatusBarNotification.svg?style=flat)](http://cocoapods.org/pods/HBStatusBarNotification)


`HBStatusBarNotification` is an extremely lightweight solution for quickly dispatching status bar overlay notifications anywhere in your iOS application using one line of code. No additional setup or configuration is required.

## Usage
Using HBStatusBarNotification is as simple as:
```swift 
HBStatusBarNotification(message: "Internet Connection Lost", backgroundColor: UIColor.red).show()
```

Optionally, you can customize any combination of the other appearances / behaviors:

```swift 
let notification = HBStatusBarNotification(message: "Internet Connected Lost", 
                        backgroundColor: UIColor.black, 
                        textColor: UIColor.red, 
                        statusBarStyle: .lightContent, 
                        duration: 6.0, 
                        font: UIFont(name: ".SFUIDisplay-Heavy", size: 10)!, 
                        notificationHeight: 40)
notification.show()
```


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

HBStatusBarNotification is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "HBStatusBarNotification"
```

## Author

havenbarnes, hab0020@auburn.edu

## License

HBStatusBarNotification is available under the MIT license. See the LICENSE file for more info.
