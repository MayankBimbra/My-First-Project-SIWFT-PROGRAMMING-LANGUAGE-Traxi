//
//  UIFonts+Extension.swift
//  Traxi
//
//  Created by IOS on 22/03/21.
//

import Foundation
import UIKit

internal enum Size : CGFloat{
    
    case VSmall = 10.0
    case Small = 12.0
    case Medium = 14.0
    case Large = 16.0
    case XLarge = 18.0
    case XXXLarge = 22.0

    case Header = 20.0

    func sizeValue() -> CGFloat {
        return self.rawValue
    }
}

extension UIFont {
    class func NunitoBold(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Nunito-Bold", size: size)!
    }

    class func NunitoRegular(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Nunito-Regular", size: size)!
    }
    
    class func NunitoSemiBold(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Nunito-SemiBold", size: size)!
    }

    class func NunitoBlack(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Nunito-Black", size: size)!
    }

//    class func NexaBold(_ size:CGFloat) -> UIFont {
//        return UIFont(name: "Nexa Bold", size: size)!
//    }
//
//    class func NexaLight(_ size:CGFloat) -> UIFont {
//        return UIFont(name: "Nexa Light", size: size)!
//    }
    
}
