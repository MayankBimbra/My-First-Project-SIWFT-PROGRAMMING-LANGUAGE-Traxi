////
////  UITextFieldPaddingClass.swift
////  Traxi
////
////  Created by IOS on 23/03/21.
////
//
//import Foundation
//import UIKit
//
//class UITextFieldExtension: UITextField {
//        
//    let padding = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 4)
//    
//    override open func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//    
//    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//    
//    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//}
//
//class paddingLeftSide: UITextField{
//    let padding = UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 12)
//
//    override open func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//
//    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//
//    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//}
