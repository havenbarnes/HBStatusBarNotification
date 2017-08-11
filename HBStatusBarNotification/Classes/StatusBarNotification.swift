//
//  StatusBarNotification.swift
//  Funnel
//
//  Created by Haven Barnes on 9/27/16.
//  Copyright © 2016 Funnel. All rights reserved.
//
import UIKit

class StatusBarNotification: UILabel {
    
    var kNotificationHeight: CGFloat = 20
    var kNotificationFont: UIFont = UIFont(name: ".SFUIDisplay-Heavy", size: 14)!
    var kNotificationDuration: TimeInterval = 3.0
    var kLightStatusBar = false
    var notificationWindow = UIWindow()
    

    init(message: String, color: UIColor, lightStatusBar: Bool = false, duration: TimeInterval = 3.0, font: UIFont = UIFont(name: ".SFUIDisplay-Heavy", size: 14)!,
         notificationHeight: CGFloat = 20) {
        
        self.kNotificationDuration = duration
        self.kNotificationFont = font
        self.kNotificationHeight = notificationHeight
        
        super.init(frame: CGRect(x: 0, y: -self.kNotificationHeight, width: UIScreen.main.bounds.width, height: kNotificationHeight))
        
        initializeNotificationWindow()
        
        notificationWindow.windowLevel = UIWindowLevelAlert
        notificationWindow.isHidden = false
        notificationWindow.isUserInteractionEnabled = false
        
        let viewController = StatusBarNotificationViewController(prefersLightStatusBarStyle: lightStatusBar)
        
        viewController.view.frame = notificationWindow.frame
        viewController.view.backgroundColor = UIColor.clear
        viewController.setNeedsStatusBarAppearanceUpdate()
        notificationWindow.rootViewController = viewController
        
        self.backgroundColor = color
        self.font = kNotificationFont
        self.textColor = UIColor.white
        self.textAlignment = .center
        self.text = message
        viewController.view.addSubview(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeNotificationWindow()
    }
    
    func initializeNotificationWindow() {
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
    
    func show() {
        self.notificationWindow.makeKeyAndVisible()
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.kNotificationHeight)
        }, completion: { complete in
            self.hide()
        })
    }
    
    func hide() {
        UIView.animate(withDuration: 0.3, delay: kNotificationDuration, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.frame = CGRect(x: 0, y: -self.kNotificationHeight, width: UIScreen.main.bounds.width, height: self.kNotificationHeight)
        }, completion: { complete in
            self.notificationWindow.isHidden = true
        })
    }
}

class StatusBarNotificationViewController: UIViewController {
    
    var prefersLightStatusBarStyle: Bool = false
    
    init(prefersLightStatusBarStyle: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.prefersLightStatusBarStyle = prefersLightStatusBarStyle
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        let style: UIStatusBarStyle = prefersLightStatusBarStyle ? .lightContent : .default
        return style
    }
}
