//
//  SignUpVC.swift
//  Traxi
//
//  Created by IOS on 22/03/21.
//

import UIKit

class SignUpVC: UIViewController {
    //MARK:- UI COMPONENTS
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var submitBtn: LoadingButton!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneNoTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var pswTF: UITextField!
    @IBOutlet weak var confirmPswTF: UITextField!
    @IBOutlet weak var messageTxtView: UITextView!
    
    //MARK:- Variables
    var controller : SignUpVC?
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        CommonFunctions.btnShadow(submitBtn)
        CommonFunctions.gradientBtn(submitBtn)
        CommonFunctions.tfPadding([nameTF, phoneNoTF, emailTF], pswTFs: [pswTF,confirmPswTF])
        CommonFunctions.CornerRadius([nameTF, phoneNoTF, emailTF, pswTF, confirmPswTF], textViews: [messageTxtView],views: [], btns: [])
        CommonFunctions.txtViewPadding(messageTxtView)
        phoneNoTF.keyboardType = .phonePad
        
        nameTF.returnKeyType = .next
        phoneNoTF.returnKeyType = .next
        emailTF.returnKeyType = .next
        pswTF.returnKeyType = .next
        confirmPswTF.returnKeyType = .next
        messageTxtView.returnKeyType = .done
        
        backBtn.addTarget(self, action: #selector(backBtnAction(_:)), for: .touchUpInside)
        submitBtn.addTarget(self, action: #selector(submitBtnAction(_:)), for: .touchUpInside)
        nameTF.delegate = self
        phoneNoTF.delegate = self
        emailTF.delegate = self
        pswTF.delegate = self
        confirmPswTF.delegate = self
        messageTxtView.delegate = self
        
    }
    // MARK: - Button Action
    @objc func backBtnAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func submitBtnAction(_ sender: UIButton){
        checkLoginValidations()
    }
    // MARK: - Functions
    func checkLoginValidations(){
        if nameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            nameTF.shake()
            CommonFunctions.toster("Please Enter Name")
            CommonFunctions.errorTF(nameTF, placeHolder: L10n.email.description)
        }else if phoneNoTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            phoneNoTF.shake()
            CommonFunctions.toster("Please Enter Phone Number")
            CommonFunctions.errorTF(phoneNoTF, placeHolder: L10n.email.description)
        }else if emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            emailTF.shake()
            CommonFunctions.toster("Please Enter Email")
            CommonFunctions.errorTF(emailTF, placeHolder: L10n.email.description)
        }else if pswTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            pswTF.shake()
            CommonFunctions.toster("Please Enter Password")
            CommonFunctions.errorTF(pswTF, placeHolder: L10n.email.description)
        }else if confirmPswTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            confirmPswTF.shake()
            CommonFunctions.toster("Please Confirm Password")
            CommonFunctions.errorTF(confirmPswTF, placeHolder: L10n.email.description)
        }else if messageTxtView.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            messageTxtView.shake()
            CommonFunctions.toster("Please Write Message")
            //CommonFunctions.errorTF(messageTxtView, placeHolder: L10n.email.description)
        }
        else{
            signUpAPI()
        }
    }
    // MARK: - SignUpAPI
    func signUpAPI(){
        self.view.endEditing(true)
        
        var params : [String : Any] = [:]
        params = [
            "name" : nameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines),
            "phone" : phoneNoTF.text!.trimmingCharacters(in: .whitespacesAndNewlines),
            "email" : emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines),
            "message" : messageTxtView.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        ]
        view.isUserInteractionEnabled = false
        submitBtn.showLoading()

        ApiHandler.callApiWithParameters(url: appConstantURL().signUpURL, withParameters: params, ofType: SignUpAPI.self, success2: { (response) in
            print(response)
            self.view.isUserInteractionEnabled = true
            self.submitBtn.hideLoading()
            self.nameTF.text = ""
            self.phoneNoTF.text = ""
            self.emailTF.text = ""
            self.messageTxtView.text = ""
            
        }, failure: { (reload, error) in
            self.view.isUserInteractionEnabled = true
            self.submitBtn.hideLoading()
            if reload{
                self.signUpAPI()
            }else{
                CommonFunctions.toster(error)
            }
        }, method: .PostWithJSON, img: nil, imageParamater: "", headerPresent: false)
    }
}
// MARK: - Extensions
extension SignUpVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTF:
            phoneNoTF.becomeFirstResponder()
        case phoneNoTF:
            emailTF.becomeFirstResponder()
        case emailTF:
            pswTF.becomeFirstResponder()
        case pswTF:
            confirmPswTF.becomeFirstResponder()
        case confirmPswTF:
            messageTxtView.becomeFirstResponder()
        case messageTxtView:
            messageTxtView.resignFirstResponder()
        default:
            view.endEditing(true)
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        CommonFunctions.tfPadding([nameTF, phoneNoTF, emailTF], pswTFs: [pswTF, confirmPswTF])
        CommonFunctions.txtViewPadding(messageTxtView)
        return true
    }
}
extension SignUpVC: UITextViewDelegate {
////    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
////        //textView.resignFirstResponder()
////        self.view.endEditing(true)
////        return true
////    }
//    func textViewDidEndEditing(_ textView: UITextView) {
//        textView.resignFirstResponder()
//        self.view.endEditing(true)
//    }
}

