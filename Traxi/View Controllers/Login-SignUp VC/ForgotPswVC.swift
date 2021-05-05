//
//  ForgotPswVC.swift
//  Traxi
//
//  Created by IOS on 22/03/21.
//

import UIKit

class ForgotPswVC: UIViewController {
    // MARK: - UI COMPONENTS
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var emailAddressTF: UITextField!
    @IBOutlet weak var sendResetLinkBtn: UIButton!
    // MARK: - Variables
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        CommonFunctions.btnShadow(sendResetLinkBtn)
        CommonFunctions.tfPadding([emailAddressTF], pswTFs: [])
        CommonFunctions.CornerRadius([emailAddressTF], textViews: [],views: [], btns: [])
        CommonFunctions.gradientBtn(sendResetLinkBtn)
        
        emailAddressTF.returnKeyType = .done
        emailAddressTF.delegate = self
        backBtn.addTarget(self, action: #selector(backBtnAction(_:)), for: .touchUpInside)
        sendResetLinkBtn.addTarget(self, action: #selector(sendResetLinkBtnAction(_:)), for: .touchUpInside)
  
    }
    // MARK: - Buttton Action
    @objc func sendResetLinkBtnAction(_ sender: UIButton) {
        checkLoginValidations()
    }
    @objc func backBtnAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - Functions
    func checkLoginValidations(){
        if emailAddressTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            emailAddressTF.shake()
            CommonFunctions.toster("Please Enter Email Address")
        }
        else{
            forgotAPI()
        }
    }
    // MARK: - ForgotAPI
    func forgotAPI(){
        self.view.endEditing(true)
        let params : [String : Any] = [
            "email" : emailAddressTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
        ]
        view.isUserInteractionEnabled = false

        ApiHandler.callApiWithParameters(url: appConstantURL().forgotURL, withParameters: params, ofType: ForgotAPI.self, success2: { (response) in
            print(response)
            self.view.isUserInteractionEnabled = true
            self.emailAddressTF.text = ""
        
        }, failure: { (reload, error) in
            self.view.isUserInteractionEnabled = true
            if reload{
                self.forgotAPI()
            }else{
                CommonFunctions.toster(error)
            }
        }, method: .PostWithJSON, img: nil, imageParamater: "", headerPresent: false)
    }
}
// MARK: - Extension
extension ForgotPswVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailAddressTF:
            emailAddressTF.resignFirstResponder()
        default:
            view.endEditing(true)
        }
        return true
    }
}
