//
//  contactUsVC.swift
//  Traxi
//
//  Created by mac1 on 22/04/21.
//

import UIKit

class contactUsVC: UIViewController, UITextViewDelegate {
    
    //MARK:- UI Components
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var contactUsLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var messageTxtView: UITextView!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBtn.addTarget(self, action: #selector(backBtnAction(_ :)), for: .touchUpInside)
        submitBtn.addTarget(self, action: #selector(submitBtnAction(_ :)), for: .touchUpInside)
        CommonFunctions.CornerRadius([], textViews: [messageTxtView], views: [headerView], btns: [submitBtn])
        CommonFunctions.txtViewPadding(messageTxtView)
        messageTxtView.delegate  = self
        messageTxtView.text = "Write Your Message"
        messageTxtView.textColor = UIColor.lightGray
    }
    
    //UITextViewDelegate Methods for writing Placeholder text in it
    func textViewDidBeginEditing(_ textView: UITextView) {
        if messageTxtView.textColor == UIColor.lightGray {
            messageTxtView.text = nil
            messageTxtView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if messageTxtView.text.isEmpty {
            messageTxtView.text = "Write Your Message"
            messageTxtView.textColor = UIColor.lightGray
        }
    }
    //MARK:- Button Actions
    @objc func backBtnAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func submitBtnAction(_ sender: UIButton){
        if !(messageTxtView.text.isEmpty){
            contactUsAPI()
            self.navigationController?.popViewController(animated: true)
        }else {
            CommonFunctions.toster("Write Message First")
        }
    }
    //MARK:- ContactUs API
    func contactUsAPI() {
        let params: [String: Any] = [
            "message": messageTxtView.text.trimmingCharacters(in: .whitespacesAndNewlines) ]
        ApiHandler.callApiWithParameters(url: appConstantURL().contactUsURL, withParameters: params, ofType: ContactUsAPI.self, success2: { (response) in
            CommonFunctions.toster(response.message!)
        }, failure: { (false, error) in
            CommonFunctions.toster(error)
        }, method: .PostWithJSON, img: nil, imageParamater: "", headerPresent: true)
    }
}


