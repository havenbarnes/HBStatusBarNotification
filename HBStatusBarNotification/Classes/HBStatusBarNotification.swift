//
//  StatusBarNotification.swift
//  HBStatusBarNotification
//
//  Created by Haven Barnes on 8/11/17.
//  Copyright © 2017 Haven Barnes. All rights reserved.
//
import UIKit

public class HBStatusBarNotification: UILabel {
    
    private var kNotificationHeight: CGFloat
    
    private var kNotificationDuration: TimeInterval
    
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
     - parameter height: The height of the notification's frame.
                                     Defaults to 20, the size of a standard status bar.
     */
    public init(message: String,
                backgroundColor: UIColor,
                textColor: UIColor = UIColor.white,
                statusBarStyle: UIStatusBarStyle = .default,
                duration: TimeInterval = 3.0,
                font: UIFont = UIFont(name: ".SFUIDisplay-Bold", size: 14)!,
                height: CGFloat = 20) {
        
        self.kNotificationDuration = duration
        self.kNotificationHeight = height
        
        super.init(frame: CGRect(x: 0, y: -self.kNotificationHeight, width: UIScreen.main.bounds.width, height: kNotificationHeight))
        
        initializeNotificationWindow()
        
        notificationWindow.windowLevel = UIWindowLevelAlert
        notificationWindow.isHidden = false
        notificationWindow.isUserInteractionEnabled = false
        
        let viewController = NotificationViewController(statusBarStyle: statusBarStyle)
        
        viewController.view.frame = notificationWindow.frame
        viewController.view.backgroundColor = UIColor.clear
        viewController.setNeedsStatusBarAppearanceUpdate()
        notificationWindow.rootViewController = viewController
        
        self.backgroundColor = backgroundColor
        self.font = font
        self.textColor = textColor
        self.textAlignment = .center
        self.text = message
        self.numberOfLines = 1
        self.minimumScaleFactor = 0.25
        self.adjustsFontSizeToFitWidth = true
        
        viewController.view.addSubview(self)
    }

    /// Required initializer. Please use the provided initializer in HBStatusBarNotification.swift
    required public init?(coder aDecoder: NSCoder) {
        kNotificationHeight = 20
        kNotificationDuration = 3
        super.init(coder: aDecoder)
        fatalError("Please use the provided initializer above.")
    }
    
    /// Initializes the new UIWindow that will be used for overlay
    private func initializeNotificationWindow() {
        let appDelegate = UIApplication.shared.delegate
        guard let wrappedWindow = appDelegate?.window else {
            print("StatusBarNotification dispatch failed - No UIWindow found for application")
            return
        }
        guard let unwrappedWindow = wrappedWindow else {
            print("StatusBarNotification dispatch failed - No UIWindow found for application")
            return
        }
        notificationWindow = UIWindow(frame: (unwrappedWindow.frame))
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

extension HBStatusBarNotification {
    
    /// Provides left and right text margins
    override public func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}

public class NotificationViewController: UIViewController {
    
    /// Preferred status bar style for overlay. Keeps transitions seamless
    private var statusBarStyle: UIStatusBarStyle
    
    public init(statusBarStyle: UIStatusBarStyle) {
        self.statusBarStyle = statusBarStyle
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.statusBarStyle = .default
        super.init(coder: aDecoder)
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
}
