//
//  UIView+Extension.swift
//  Traxi
//
//  Created by IOS on 25/03/21.
//

import Foundation
import UIKit

//extension UIView
extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-12.0, 12.0, -8.0, 8.0, -4.0, 4.0, -2.0, 2.0 ]
        layer.add(animation, forKey: "shake")
    }
}

extension UIView {
  func dropShadow() {
    layer.shadowColor = UIColor.gray.cgColor
    layer.shadowOpacity = 1
    layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
    layer.shadowRadius = 1
  }
  func borderOfView(){
    layer.cornerRadius = 10
    layer.borderWidth = 1
    layer.borderColor =  UIColor(red: 0.9098039216, green: 0.7843137255, blue: 0.3411764706, alpha: 1).cgColor
  }
}

extension UIView {
    func createDottedLine(width: CGFloat, color: CGColor) {
        self.backgroundColor = .clear
        let caShapeLayer = CAShapeLayer()
        caShapeLayer.strokeColor = color
        caShapeLayer.lineWidth = width
        caShapeLayer.lineDashPattern = [2,3]
        let cgPath = CGMutablePath()
        let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: self.layer.bounds.height)]
        cgPath.addLines(between: cgPoint)
        caShapeLayer.path = cgPath
        layer.addSublayer(caShapeLayer)
    }
}
