//
//  StatusBarNotification.swift
//  HBStatusBarNotification
//
//  Created by Haven Barnes on 8/11/17.
//  Copyright © 2017 Haven Barnes. All rights reserved.
//
import UIKit

@available(iOS 11.0, *)
public class HBStatusBarNotification: UITextField {
    
    private var kNotificationHeight: CGFloat = 0
    private var kNotificationDuration: TimeInterval = 0.0
    private var notificationWindow: UIWindow!
    
    private let defaultNotchlessHeight: CGFloat = 20
    private let defaultNotchHeight: CGFloat = 60
    
    private var deviceHasNotch: Bool {
        return UIApplication.shared.keyWindow?.safeAreaInsets.top != 20
    }

    private var defaultNotificationHeight: CGFloat {
        return deviceHasNotch ? defaultNotchHeight : defaultNotchlessHeight
    }
    
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
                         Defaults to the sizes appropriate for device status bar area.
     - parameter autorotates: Whether the notification should rotate with device.
                         Defaults to true.
     */
    public init(message: String,
                backgroundColor: UIColor,
                textColor: UIColor = UIColor.white,
                statusBarStyle: UIStatusBarStyle = .default,
                duration: TimeInterval = 3.0,
                font: UIFont = UIFont(name: ".SFUIDisplay-Medium", size: 14)!,
                height: CGFloat? = nil,
                autorotates: Bool = true) {
        
        super.init(frame: CGRect(x: 0, y: -self.kNotificationHeight, width: UIScreen.main.bounds.width, height: self.kNotificationHeight))
        
        self.kNotificationHeight = height ?? defaultNotificationHeight
        self.kNotificationDuration = duration
        
        let frame = UIApplication.shared.keyWindow?.frame
        self.notificationWindow = UIWindow(frame: (frame ?? CGRect()))
        
        self.notificationWindow.windowLevel = UIWindow.Level.alert
        self.notificationWindow.isHidden = false
        self.notificationWindow.isUserInteractionEnabled = false
        
        let viewController = NotificationViewController(statusBarStyle: statusBarStyle, autorotates: autorotates)
        viewController.view.frame = notificationWindow.frame
        viewController.view.backgroundColor = UIColor.clear
        viewController.setNeedsStatusBarAppearanceUpdate()
        self.notificationWindow.rootViewController = viewController
        
        self.backgroundColor = backgroundColor
        self.font = font
        self.textColor = textColor
        self.textAlignment = .center
        self.text = message
        self.isUserInteractionEnabled = false
        self.textAlignment = .center
        self.contentVerticalAlignment = deviceHasNotch ? .bottom : .center
        
        viewController.view.addSubview(self)
    }

    /// Required initializer. Please use the provided initializer in HBStatusBarNotification.swift
    required public init?(coder aDecoder: NSCoder) {
        kNotificationHeight = 20
        kNotificationDuration = 3
        notificationWindow = UIWindow()
        super.init(coder: aDecoder)
        fatalError("Please use the provided initializer in HBStatusBarNotification.swift.")
    }
    
    /// Overrides text bounds for proper margin
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        var boundsAdjusted = bounds
        // Left / Right margins
        boundsAdjusted.origin.x += 5
        boundsAdjusted.size.width -= 10
        // Bottom margin for notch-screened notifications
        if (deviceHasNotch) {
            boundsAdjusted.size.height -= 5
        }
        return boundsAdjusted
    }
    
    /// Called to dispatch the notification
    public func show() {
        self.notificationWindow.makeKeyAndVisible()
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.kNotificationHeight)
        }, completion: { complete in
            self.hide()
        })
    }
   
    /// Hides the notification after designated duration
    private func hide() {
        UIView.animate(withDuration: 0.3, delay: kNotificationDuration, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.frame = CGRect(x: 0, y: -self.kNotificationHeight, width: UIScreen.main.bounds.width, height: self.kNotificationHeight)
        }, completion: { complete in
            self.notificationWindow.isHidden = true
        })
    }
}

public class NotificationViewController: UIViewController {
    
    /// Preferred status bar style for overlay. Keeps transitions seamless
    private var statusBarStyle: UIStatusBarStyle
    
    /// Boolean that indicates whether view controller autorotates
    private var autorotates: Bool
    
    public init(statusBarStyle: UIStatusBarStyle = .default,
                autorotates: Bool = true) {
        self.statusBarStyle = statusBarStyle
        self.autorotates = autorotates
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        statusBarStyle = .default
        autorotates = true
        super.init(coder: aDecoder)
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    public override var shouldAutorotate: Bool {
        return autorotates
    }
}
