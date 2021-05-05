//
//  Images.swift
//  Traxi
//
//  Created by IOS on 23/03/21.
//

import Foundation
import UIKit

#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit.UIImage
    typealias Image = UIImage
#elseif os(OSX)
    import AppKit.NSImage
    typealias Image = NSImage
#endif

enum Asset : String {

    case ic_hideeye_review = "visibility_off"
    case ic_eye_review = "visibility"
    
    case drop_down = "drop_down"
    case drop_up = "drop_up"
    
    case deliveries_b = "deliveries_b"
    case deliveries_w = "deliveries_w"
    
    case stores_b = "stores_b"
    case stores_w = "stores_w"
    
    case password = "password"
    
    func image () -> UIImage{
        return UIImage(named: self.rawValue)!
    }
}

extension Image {
    convenience init!(asset: Asset) {
        self.init(named: asset.rawValue)
    }
}
