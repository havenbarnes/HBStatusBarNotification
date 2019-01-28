//
//  ViewController.swift
//  HBStatusBarNotification
//
//  Created by havenbarnes on 08/11/2017.
//  Copyright (c) 2017 havenbarnes. All rights reserved.
//

import UIKit
import HBStatusBarNotification

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @IBAction func normalNotificationButtonPressed(_ sender: Any) {
        HBStatusBarNotification(message: textField.text!, backgroundColor: UIColor.blue).show()
    }
    
    @IBAction func longerNotificationButtonPressed(_ sender: Any) {
        HBStatusBarNotification(message: textField.text!,
                                backgroundColor: UIColor("D56554"),
                                textColor: UIColor.black,
                                duration: 6.0).show()
    }
    
    @IBAction func biggerNotificationButtonPressed(_ sender: Any) {
        HBStatusBarNotification(message: textField.text!,
                                backgroundColor: UIColor("17D412"),
                                font: UIFont(name: ".SFUIDisplay-Black", size: 30)!,
                                height: 90.0).show()
    }
}

extension UIColor {
    convenience init(_ hex: String?) {
        guard let hex = hex else {
            self.init(white: 0.5, alpha: 1)
            return
        }
        
        let hexString = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hexString).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hexString.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

