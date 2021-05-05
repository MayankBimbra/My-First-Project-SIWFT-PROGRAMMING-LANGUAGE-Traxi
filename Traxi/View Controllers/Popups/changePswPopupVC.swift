//
//  changePswPopupVC.swift
//  Traxi
//
//  Created by mac1 on 22/04/21.
//

import UIKit

class changePswPopupVC: UIViewController {
    // MARK: - Variables
    var btneye : UIButton!
    var btneye1 : UIButton!
    var password : UIButton!
    var password1 : UIButton!
    //MARK:- UI Components
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var changePswView: UIView!
    @IBOutlet weak var changePswLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var currentPswTF: UITextField!
    @IBOutlet weak var newPswTF: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        myView.backgroundColor = UIColor(rgb: 0xFFF6C7)
        CommonFunctions.CornerRadius([currentPswTF,newPswTF], textViews: [], views: [myView,changePswView], btns: [submitBtn])
        CommonFunctions.btnShadow(submitBtn)
        CommonFunctions.tfPadding([currentPswTF,newPswTF], pswTFs: [])
        zoomInAnimationShow()
        //zoomOutAnimationShow()
        btneye = UIButton()
        btneye.imageEdgeInsets = UIEdgeInsets(top: 6, left: 4, bottom: 6, right: 10)
        btneye.tintColor = UIColor(rgb: 0x4B4B4B)
        btneye.setImage(Asset.ic_hideeye_review.image(), for: .normal)
        btneye.addTarget(self, action: #selector(btnActEye(_:)) , for: .touchUpInside)
        currentPswTF.rightView = btneye
        currentPswTF.rightViewMode = .always
        
        btneye1 = UIButton()
        btneye1.imageEdgeInsets = UIEdgeInsets(top: 6, left: 4, bottom: 6, right: 10)
        btneye1.tintColor = UIColor(rgb: 0x4B4B4B)
        btneye1.setImage(Asset.ic_hideeye_review.image(), for: .normal)
        btneye1.addTarget(self, action: #selector(btnActEye1(_:)) , for: .touchUpInside)
        newPswTF.rightView = btneye1
        newPswTF.rightViewMode = .always
        
        password = UIButton()
        password.imageEdgeInsets = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 4)
        password.tintColor = UIColor(rgb: 0x4B4B4B)
        password.setImage(Asset.password.image(), for: .normal)
        currentPswTF.leftView = password
        currentPswTF.leftViewMode = .always
        
        password1 = UIButton()
        password1.imageEdgeInsets = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 4)
        password1.tintColor = UIColor(rgb: 0x4B4B4B)
        password1.setImage(Asset.password.image(), for: .normal)
        newPswTF.leftView = password1
        newPswTF.leftViewMode = .always
        
        cancelBtn.addTarget(self, action: #selector(cancelBtnAction(_:)), for: .touchUpInside)
        submitBtn.addTarget(self, action: #selector(submitBtnAction(_:)), for: .touchUpInside)

    }
    //MARK:-  Button Actions
    @objc func cancelBtnAction(_ sender: UIButton){
        zoomOutAnimationHide()
    }
    @objc func btnActEye(_ sender: UIButton){
        CommonFunctions.btnActEye(btneye, pswTF: currentPswTF)
    }
    @objc func btnActEye1(_ sender: UIButton){
        CommonFunctions.btnActEye(btneye1, pswTF: newPswTF)
    }
    @objc func submitBtnAction(_ sender: UIButton){
        if currentPswTF.text!.isEmpty || newPswTF.text!.isEmpty {
//            CommonFunctions.shak
            CommonFunctions.toster("Enter your Passwords")
        }
        else {
            self.changePswAPI()
        }
    }
    
    
    //MARK:- Methods/Function for Animation
    func zoomOutAnimationHide(){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0, options: [], animations: {
                        self.myView!.transform = CGAffineTransform(scaleX: 0.02, y: 0.02)
                       }) { (success) in
            self.view.removeFromSuperview()
        }
    }
    func zoomInAnimationShow(){
        self.myView!.transform = CGAffineTransform(scaleX: 10, y: 10)
        //
        self.view.alpha = 0.0
        self.myView!.alpha = 0.0
        UIView.animate(withDuration: 0.02, animations: {
            self.view.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.8, animations: {
                //
                self.myView!.alpha = 1.0
                self.myView!.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }) { _ in
                UIView.animate(withDuration: 0.2, animations: {
                    self.myView!.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            }
        }
    }
    func zoomOutAnimationShow(){
        self.myView!.transform = CGAffineTransform(scaleX: 0.02, y: 0.02)
        //
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.02, animations: {
            self.view.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.7, animations: {
                //
                self.myView!.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }) { _ in
                UIView.animate(withDuration: 0.2, animations: {
                    self.myView!.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            }
        }
    }
}
//MARK:- Extensions
extension changePswPopupVC {
    func changePswAPI(){
        let params:[String: Any] = [
            "old_password": currentPswTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
            "new_password": newPswTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""]
        
        ApiHandler.callApiWithParameters(url: appConstantURL().changePassowrdURL, withParameters: params, ofType: ChangePswAPI.self, success2: { (response) in
            print(response)
            CommonFunctions.toster(response.message ?? "")
            self.zoomOutAnimationHide()
        }, failure: { (false, error) in
            CommonFunctions.toster(error)
        }, method: ApiMethod.PUT, img: nil, imageParamater: "", headerPresent: true)
    }
}
