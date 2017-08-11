//
//  StatusBarNotification.swift
//  Funnel
//
//  Created by Haven Barnes on 9/27/16.
//  Copyright © 2016 Funnel. All rights reserved.
//
import UIKit

public class HBStatusBarNotification: UILabel {
    
    private var kNotificationHeight: CGFloat = 20
    private var kNotificationFont: UIFont = UIFont(name: ".SFUIDisplay-Medium", size: 14)!
    private var kNotificationDuration: TimeInterval = 3.0
    private var kLightStatusBar = false
    private var notificationWindow = UIWindow()

    /**
     Initialize a status bar notification with a range 
     of customization options.
     
     - parameter message: A string message that you want displayed in the notification.
     - parameter backgroundColor: The desired color for the background of the notification.
     - parameter textColor: The desired color for text content of the notification.
                            Defaults to white.
     - parameter statusBarStyle: The status bar style of the view on which the notification
                           will be displayed. Keeps the animations seamless.
                                 Defaults to dark status bar.
     - parameter duration: The duration that the notification should display.
                           Defaults to 3 seconds.
     - parameter font: The font for the text content of the notification.
                       Defaults to San Francisco Medium, size 14
     - parameter notificationHeight: The height of the notification's frame.
                                     Defaults to 20, the size of a standard status bar.
     */
    public init(message: String,
                backgroundColor: UIColor,
                textColor: UIColor = UIColor.white,
                statusBarStyle: UIStatusBarStyle = .default,
                duration: TimeInterval = 3.0,
                font: UIFont = UIFont(name: ".SFUIDisplay-Medium", size: 14)!,
                notificationHeight: CGFloat = 20) {
        
        self.kNotificationDuration = duration
        self.kNotificationFont = font
        self.kNotificationHeight = notificationHeight
        
        super.init(frame: CGRect(x: 0, y: -self.kNotificationHeight, width: UIScreen.main.bounds.width, height: kNotificationHeight))
        
        initializeNotificationWindow()
        
        notificationWindow.windowLevel = UIWindowLevelAlert
        notificationWindow.isHidden = false
        notificationWindow.isUserInteractionEnabled = false
        
        let viewController = StatusBarNotificationViewController(statusBarStyle: statusBarStyle)
        
        viewController.view.frame = notificationWindow.frame
        viewController.view.backgroundColor = UIColor.clear
        viewController.setNeedsStatusBarAppearanceUpdate()
        notificationWindow.rootViewController = viewController
        
        self.backgroundColor = backgroundColor
        self.font = kNotificationFont
        self.textColor = textColor
        self.textAlignment = .center
        self.text = message
        viewController.view.addSubview(self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeNotificationWindow()
    }
    
    private func initializeNotificationWindow() {
        let appDelegate = UIApplication.shared.delegate
        guard let wrappedWindow = appDelegate?.window else {
            print("StatusBarNotification dispatch failed - No UIWindow found for application")
            return
        }
        guard let window = wrappedWindow else {
            print("StatusBarNotification dispatch failed - No UIWindow found for application")
            return
        }
        notificationWindow = UIWindow(frame: (window.frame))
    }
    
    /// Called to dispatch the notification
    public func show() {
        self.notificationWindow.makeKeyAndVisible()
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.kNotificationHeight)
        }, completion: { complete in
            self.hide()
        })
    }
   
    /// Hides the notification after designated duration
    private func hide() {
        UIView.animate(withDuration: 0.3, delay: kNotificationDuration, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.frame = CGRect(x: 0, y: -self.kNotificationHeight, width: UIScreen.main.bounds.width, height: self.kNotificationHeight)
        }, completion: { complete in
            self.notificationWindow.isHidden = true
        })
    }
}

public class StatusBarNotificationViewController: UIViewController {
    
    private var statusBarStyle: UIStatusBarStyle = .default
    
    public init(statusBarStyle: UIStatusBarStyle) {
        super.init(nibName: nil, bundle: nil)
        self.statusBarStyle = statusBarStyle
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
}
