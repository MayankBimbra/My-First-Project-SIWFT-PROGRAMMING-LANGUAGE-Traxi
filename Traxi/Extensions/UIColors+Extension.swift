//
//  UIColors+Extension.swift
//  Traxi
//
//  Created by IOS on 23/03/21.
//

import Foundation
import UIKit

extension UIColor {

    open class var ButtonGradientDarkColor : UIColor{
        get {
            return UIColor(named: "ButtonGradientDarkColor") ?? UIColor.white
        }
    }
    
    open class var ButtonGradientLightColor : UIColor{
        get {
            return UIColor(named: "ButtonGradientLightColor") ?? UIColor.black
        }
    }
    
    open class var textColorMain : UIColor{
        get {
            return UIColor(named: "TextColorMain") ?? UIColor.black
        }
    }
    
    open class var textColorPlaceholder : UIColor{
        get {
            return UIColor(named: "TextColorPlaceholder") ?? UIColor.black
        }
    }
    
    open class var bGColor : UIColor{
        get {
            return UIColor(named: "BGColor") ?? UIColor.black
        }
    }
    open class var errorColor : UIColor{
        get {
            return UIColor(named: "RedColor") ?? UIColor.black
        }
    }
    open class var TextFieldBorderColor : UIColor{
        get {
            return UIColor(named: "TextFieldBorderColor") ?? UIColor.black
        }
    }
 
    open class var appWhiteColor : UIColor{
        get {
            return UIColor(named: "WhiteColor") ?? UIColor.white
        }
    }
    
       open class var viewBackgroundColor : UIColor{
           get {
               return UIColor(named: "viewBackgroundColor") ?? UIColor.white
           }
       }
    
}
extension UIColor {

    convenience init(rgb: UInt) {
        self.init(rgb: rgb, alpha: 1.0)
    }

    convenience init(rgb: UInt, alpha: CGFloat) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}
