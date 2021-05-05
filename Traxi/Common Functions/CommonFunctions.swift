//
//  CommonFunctions.swift
//  Traxi
//  Created by IOS on 23/03/21.
//

import Foundation
import UIKit
import Toaster
import SwiftEntryKit
import DropDown

class EntryAttributeWrapper {
    var attributes: EKAttributes
    init(with attributes: EKAttributes) {
        self.attributes = attributes
    }
}

class CommonFunctions {
    //MARK:- Variables
    var attributes = EKAttributes()
    var btneye : UIButton!
    
    //MARK:- Shadow to Button
    static func btnShadow(_ btn : UIButton) {
        btn.layer.shadowColor =  UIColor(rgb: 0x00000029).cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        //btn.layer.masksToBounds = true
        btn.layer.shadowOpacity = 0.6
        btn.layer.shadowRadius = 4.0
        //btn.layer.masksToBounds = false
        btn.clipsToBounds = true
        
        btn.layer.cornerRadius = 4.0
    }
    static func viewShadow(_ view: UIView){
        view.layer.shadowColor =  UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        view.layer.shadowOpacity = 0.2
    }
    //MARK:- Border to Button
    static func btnBorder(_ btn: UIButton){
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 4
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor(rgb: 0xFF148E).cgColor
    }
    //MARK:- Padding to TextView
    static func txtViewPadding(_ textView: UITextView) {
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 6, bottom: 10, right: 10)
        textView.tintColor = .black
        textView.layer.borderColor = UIColor.clear.cgColor
    }
    //MARK:- Padding to TextField
    static func tfPadding(_ tfs: [UITextField], pswTFs: [UITextField]){
        for tf in tfs {
            tf.leftView = UIView(frame: CGRect(x: 10, y: 0, width: 10, height: tf.frame.height))
            tf.leftViewMode = .always
            
            //   Create a padding view for padding on right
            tf.rightView = UIView(frame: CGRect(x: 10, y: 0, width: 10, height: tf.frame.height))
            tf.rightViewMode = .always
            tf.attributedPlaceholder  = NSAttributedString(string: tf.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.textColorPlaceholder])
            tf.tintColor = UIColor.textColorPlaceholder
            tf.layer.borderColor = UIColor.TextFieldBorderColor.cgColor
        }
        for pswtf in pswTFs {
            pswtf.leftView = UIView(frame: CGRect(x: 10, y: 0, width: 10, height: pswtf.frame.height))
            pswtf.leftViewMode = .always
            pswtf.attributedPlaceholder  = NSAttributedString(string: pswtf.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.textColorPlaceholder])
            pswtf.tintColor = UIColor.textColorPlaceholder
            pswtf.layer.borderColor = UIColor.TextFieldBorderColor.cgColor
        }
    }
    //MARK:- Left Padding to Textfield
    //    static func tfLeftPadding(_ tfs: [UITextField]){
    //        for tf in tfs {
    //            tf.leftView = UIView(frame: CGRect(x: 10, y: 0, width: 10, height: tf.frame.height))
    //            tf.leftViewMode = .always
    //            tf.attributedPlaceholder  = NSAttributedString(string: tf.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.textColorPlaceholder])
    //            tf.tintColor = UIColor.textColorPlaceholder
    //            tf.layer.borderColor = UIColor.clear.cgColor
    //        }
    //    }
    //MARK:- Password textfield Eye
    static func btnActEye(_ btneye: UIButton, pswTF: UITextField ){
        pswTF.isSecureTextEntry = !pswTF.isSecureTextEntry
        let img1 = Asset.ic_eye_review.image().withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        let img2 = Asset.ic_hideeye_review.image().withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        btneye.setImage( pswTF.isSecureTextEntry ? img1 : img2, for: .normal)
        if pswTF.isSecureTextEntry {
            btneye.setImage(img2, for: .normal)
        }else{
            btneye.setImage(img1, for: .normal)
        }
    }
    //MARK:- Gradient To Button
    static func gradientBtn(_ btn: UIButton) {
        // Create a gradient layer
        let gradient = CAGradientLayer()
        // gradient colors in order which they will visually appear
        gradient.colors = [UIColor.ButtonGradientDarkColor.cgColor, UIColor.ButtonGradientLightColor.cgColor]
        
        // Gradient from left to right
        gradient.startPoint = CGPoint(x: 0.0, y: 0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        // set the gradient layer to the same size as the view
        gradient.frame = btn.bounds
        // add the gradient layer to the views layer for rendering
        btn.layer.insertSublayer(gradient, at: 0)
        //        btn.clipsToBounds = true
    }
    //MARK:- CornerRadius to Textfield
    static func CornerRadius(_ tfs: [UITextField], textViews: [UITextView], views: [UIView], btns: [UIButton]){
        for tf in tfs {
            tf.layer.cornerRadius = 4.0
            tf.layer.borderColor = UIColor(rgb: 0xE8C857).cgColor
            tf.layer.borderWidth = 1
        }
        for tv in textViews {
            tv.layer.cornerRadius = 4.0
            tv.layer.borderColor = UIColor(rgb: 0xE8C857).cgColor
            tv.layer.borderWidth = 1
        }
        for view in views {
            view.layer.cornerRadius = 6.0
            view.layer.borderColor = UIColor(rgb: 0xE8C857).cgColor
            view.layer.borderWidth = 1
        }
        for btn in btns {
            btn.layer.cornerRadius = 4.0
        }
    }

    //MARK:- Toster
    static func toster(_ txt : String){
        let attributesWrapper: EntryAttributeWrapper = {
            var attributes = EKAttributes()
            attributes.positionConstraints = .fullWidth
            attributes.hapticFeedbackType = .success
            attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
            attributes.entryBackground = .visualEffect(style: .dark)
            return EntryAttributeWrapper(with: attributes)
        }()
        let title = EKProperty.LabelContent(
            text: txt,
            style: EKProperty.LabelStyle(font: UIFont.boldSystemFont(ofSize: 16), color: EKColor.white, alignment: NSTextAlignment.center, displayMode: .light, numberOfLines: 0)
        )
        let description = EKProperty.LabelContent(
            text: "",
            style: EKProperty.LabelStyle(
                font: UIFont.systemFont(ofSize: 1, weight: .light),
                color: .black
            )
        )
        let simpleMessage = EKSimpleMessage(
            title: title,
            description: description
        )
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributesWrapper.attributes)
    }
    //MARK:- Error in textfield
    static func errorTF(_ tf : UITextField, placeHolder : String){
        tf.layer.borderColor = UIColor.errorColor.cgColor
        tf.tintColor = UIColor.errorColor
        tf.layer.borderWidth = 1
        tf.placeholder = placeHolder
    }
    
    
    // for getting navigation controller
    static func getNavigationController() -> UINavigationController{
        return UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
    }
    
    // for getting top most view controller
    static func getTopMostViewController() -> UIViewController?{
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
            // topController should now be your topmost view controller
        }
        return nil
    }
    
    //Lodaer On View
    static func hideLoader(){
        let topView = getTopMostViewController()?.view
        if topView != nil{
            for (num,subView) in topView!.subviews.enumerated(){
                if subView.tag == 111{
                    topView!.subviews[num].removeFromSuperview()
                }
            }
        }
    }
    
    static func hideLoader(_ onView : UIView){
        let topView = onView
        for (num,subView) in topView.subviews.enumerated(){
            if subView.tag == 111{
                topView.subviews[num].removeFromSuperview()
            }
        }
    }
    
    static func showLoader(){
        let topView = getTopMostViewController()?.view
        let loadingView = UIView(frame : CGRect(x: 0, y: 0, width: topView?.frame.width ?? 0, height: topView?.frame.height ?? 0))
        loadingView.backgroundColor = UIColor.black
        loadingView.alpha = 0.6
        let laodingFrame = SpinnerView(frame: CGRect(x: (topView?.frame.width ?? 0)/2 - 20, y: (topView?.frame.height ?? 0)/2 - 20, width: 40, height: 40))
        loadingView.addSubview(laodingFrame)
        loadingView.tag = 111
        var present = false
        if topView != nil{
            for (_,subView) in topView!.subviews.enumerated(){
                if subView.tag == 111 || subView.tag == 191 {
                    present = true
                }
            }
        }
        if !present{
            topView?.addSubview(loadingView)
        }
    }
    static func showLoader(_ onView : UIView){
        let topView = onView
        let loadingView = UIView(frame : CGRect(x: 0, y: 0, width: topView.frame.width, height: topView.frame.height))
        loadingView.backgroundColor = UIColor.black
        loadingView.alpha = 0.6
        let laodingFrame = SpinnerView(frame: CGRect(x: topView.frame.width/2 - 20, y: topView.frame.height/2 - 20, width: 40, height: 40))
        loadingView.addSubview(laodingFrame)
        loadingView.tag = 111
        var present = false
        for (_,subView) in topView.subviews.enumerated(){
            if subView.tag == 111 {
                present = true
            }
        }
        if !present{
            topView.addSubview(loadingView)
        }
    }
    
    //MARK:- Logout
    static func logout(_ isLogout : Bool = true){
        var vc : UIViewController!
        if isLogout{
            vc = LoginVC.instantiateFromAppStoryboard(appStoryboard: AppStoryboard.Main)
        }else{
            vc = SignUpVC.instantiateFromAppStoryboard(appStoryboard: AppStoryboard.Main)
        }
        CommonFunctions.getNavigationController().viewControllers.insert(vc, at: 0)
        CommonFunctions.getNavigationController().popToRootViewController(animated: false)
    }
    //MARK:- Get Image
    static func getImage(_ name : String, quality: Image_Quality) -> String{
        let split_string = name.prefix(4)
        if name == "" || name == "null"{
            return ""
        }
        if name.count < 10{
          print(name)
        }
        if split_string == "http" {
          return name
        }else{
            return "\(appConstantURL().BASE_URL)aws/file?filename=\(name)\(quality.rawValue)"
        }
}

//aws/file?filename=1617191605681-file.jpeg&folder=small
//https://app-transfer.com:3001/api/aws/file?filename=1617191605681-file.jpeg&folder=small
//MARK:- Drop Down Static Function
    static func dropDown(_ imageView: UIImageView, dropDown: DropDown, sender: UIButton, dataSource: [String]) {
        imageView.image = Asset.drop_up.image()
        dropDown.dataSource = dataSource
        dropDown.anchorView = sender
        dropDown.animationduration = 0.2
        dropDown.backgroundColor = UIColor(rgb: 0xFFDE67)
        
        dropDown.selectedTextColor = UIColor.appWhiteColor
        dropDown.selectionBackgroundColor = UIColor.ButtonGradientLightColor
        dropDown.textColor = .black
        dropDown.cornerRadius = 4.0
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height + 2)
//        dropDown.layer.borderWidth = 15
//        dropDown.layer.borderColor = UIColor.black.cgColor
        dropDown.show()
        dropDown.cancelAction = { () in
            imageView.image = Asset.drop_down.image()
        }
    }
   
    //MARK:- To Extract Date and Timein12hrs Format
    static func dateAndTime(_ fullDateAndTime:String) -> (String, String) {
        var Time = ""
        var date = ""
        let dateAsString = fullDateAndTime
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let TimeDate = (dateFormatter.date(from: dateAsString))
        dateFormatter.dateFormat =  "h:mm a"
        Time = dateFormatter.string(from: TimeDate!)
//        print("12 hour formatted Time:",Time)
        
        dateFormatter.dateFormat = "d-MMM-yyyy"
        date = dateFormatter.string(from: TimeDate!)
//        print("12 hour formatted Date:",date)
        return (date,Time)
        }
}
