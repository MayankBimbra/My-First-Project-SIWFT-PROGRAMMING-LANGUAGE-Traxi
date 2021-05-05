//
//  ViewController.swift
//  Traxi
//
//  Created by IOS on 22/03/21.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import AuthenticationServices

class LoginVC: UIViewController {
    
    // MARK: - UI COMPONENTS
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var pswTF: UITextField!
    @IBOutlet weak var forgotPswBtn: UIButton!
    @IBOutlet weak var signInBtn: LoadingButton!
    @IBOutlet weak var driverBtn: UIButton!
    @IBOutlet weak var faceBookBtn: FBLoginButton!
    @IBOutlet weak var googlebtn: LoadingButton!
    //@IBOutlet weak var appleBtn: LoadingButton!
    @IBOutlet weak var appleBtn: ASAuthorizationAppleIDButton!
    @IBOutlet weak var stkViewSocialLogin: UIStackView!
    
    // MARK: - Variables
    var btneye : UIButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facebookLogin()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        
        setUpUI()
//        let Btn = ASAuthorizationAppleIDButton()
//        Btn.addTarget(self,action: #selector(appleBtnAction), for: .touchUpInside)
//        self.stkViewSocialLogin.addArrangedSubview(Btn)
        
        
        CommonFunctions.gradientBtn(signInBtn)
        CommonFunctions.btnShadow(signInBtn)
        CommonFunctions.btnBorder(driverBtn)
        CommonFunctions.tfPadding([emailTF], pswTFs: [pswTF])
        CommonFunctions.CornerRadius([emailTF, pswTF], textViews: [],views: [], btns: [])
        // CommonFunctions.tfLeftPadding([pswTF])
        signInBtn.addTarget(self, action: #selector(signinBtnAction(_:)), for: .touchUpInside)
        driverBtn.addTarget(self, action: #selector(driverBtnAction(_:)), for: .touchUpInside)
        forgotPswBtn.addTarget(self, action: #selector(forgotBtnAction(_:)), for: .touchUpInside)
        faceBookBtn.addTarget(self, action: #selector(faceBookBtnAction(_:)), for: .touchUpInside)
        googlebtn.addTarget(self, action: #selector(googlebtnAction(_:)), for: .touchUpInside)
        appleBtn.addTarget(self, action: #selector(appleBtnAction(_:)), for: .touchUpInside)
        
        emailTF.delegate = self
        pswTF.delegate = self
        emailTF.returnKeyType = .next
        pswTF.returnKeyType = .done
        // pswTF.isHidden = true
        
    }
    // MARK: - View Did Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(L10n.email.string)
        emailTF.placeholder = L10n.email.string
    }
    //MARK:- Simple Methods/Functions
    // MARK: - Button Action
    @IBAction func changeLangAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: Identifier.localizationVC)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @objc func btnActEye(_ sender: UIButton){
        CommonFunctions.btnActEye(btneye, pswTF: pswTF)
    }
    @objc func signinBtnAction(_ sender: UIButton){
        checkLoginValidations()
    }
    @objc func driverBtnAction(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(identifier: Identifier.signUpVC)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @objc func forgotBtnAction(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(identifier: Identifier.forgotPswVC) 
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @objc func faceBookBtnAction(_ sender: UIButton){
        
    }
    @objc func googlebtnAction(_ sender: UIButton){
        googleLogin()
    }
    
    
    // MARK: - Functions
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func checkLoginValidations(){
        if emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            emailTF.shake()
            CommonFunctions.toster("Please Enter Email")
            CommonFunctions.errorTF(emailTF, placeHolder: L10n.email.description)
        }else if (isValidEmail(emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)) == false){
            CommonFunctions.toster("Please Enter Correct Email Id")
        }
        //else if(isValidEmail(emailTF.text!) == true){
        else if pswTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            pswTF.shake()
            CommonFunctions.toster("Please Enter Password")
            CommonFunctions.errorTF(pswTF, placeHolder: L10n.password.description)
        }
        else{
            loginAPI()
        }
        //}
        
    }
    // MARK: - LoginAPI
    func loginAPI(){
        self.view.endEditing(true)
        let params : [String : Any] = [
            "email" : emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
            "country_code": "+91",
            "phone" : emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
            "password" : pswTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
            "fcm_id": "xyz" ,
            "device_id" : "sas" ,
            "device_type" : 2 ,
            "app_version": 1.0
        ]
        view.isUserInteractionEnabled = false
        CommonFunctions.showLoader()
        signInBtn.showLoading()
        
        ApiHandler.callApiWithParameters(url: appConstantURL().LoginURL, withParameters: params, ofType: LoginAPI.self, success2: { (response) in
            // token = response.token!
            coreData.shared.fromSignUpData(response)
            self.view.isUserInteractionEnabled = true
            
            coreData.shared.getData()
            if coreData.shared.accessToken != "" {
                
                let vc = tabbarVC.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
                self.navigationController?.pushViewController(vc, animated: false)
                
            }
            //            if response.user?.isPhoneVerifed == 0{
            //             //   let vc = phoneVerificationVC.instantiateFromAppStoryboard(appStoryboard: AppStoryboard.Main)
            //              //  self.controller!.navigationController?.pushViewController(vc, animated: true)
            //                CommonFunctions.toster("Phone Number is not Verified.. ")
            //            }else{
            //                let vc = tabbarVC.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
            //                self.navigationController?.pushViewController(vc, animated: true)
            //            }
            CommonFunctions.hideLoader()
            self.signInBtn.hideLoading()
            
            CommonFunctions.toster("Successfully Login")
            //            let vc = tabbarVC.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
            //            self.navigationController?.pushViewController(vc, animated: true)
            
            //            let story = UIStoryboard.init(name: "TabBar", bundle: Bundle.main)
            //            let vc = story.instantiateViewController(identifier: "tabbarVC") as! tabbarVC
            //            self.navigationController?.pushViewController(vc, animated: true)
            
            
            self.emailTF.text = ""
            self.pswTF.text = ""
            
        }, failure: { (reload, error) in
            self.view.isUserInteractionEnabled = true
            CommonFunctions.hideLoader()
            self.signInBtn.hideLoading()
            //            if reload{
            //              //  self.loginAPI()
            //            }else{
            CommonFunctions.toster(error)
            //            }
        }, method: .PostWithJSON, img: nil, imageParamater: "", headerPresent: false)
    }
}
// MARK: - Extension
extension LoginVC: UITextFieldDelegate{
    func setUpUI() {
        btneye = UIButton()
        btneye.imageEdgeInsets = UIEdgeInsets(top: 6, left: 4, bottom: 6, right: 10)
        btneye.tintColor = UIColor(rgb: 0x4B4B4B)
        btneye.setImage(Asset.ic_hideeye_review.image(), for: .normal)
        btneye.addTarget(self, action: #selector(btnActEye(_:)) , for: .touchUpInside)
        pswTF.rightView = btneye
        pswTF.rightViewMode = .always
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTF:
            pswTF.becomeFirstResponder()
        case pswTF:
            pswTF.resignFirstResponder()
        default:
            view.endEditing(true)
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        CommonFunctions.tfPadding([emailTF], pswTFs: [pswTF])
        //CommonFunctions.tfLeftPadding([pswTF])
        return true
    }
}
//MARK:- Google Login Btn Delegate
extension LoginVC: GIDSignInDelegate{
    func googleLogin(){
        self.googlebtn.showLoading()
        self.view.isUserInteractionEnabled = false
        GIDSignIn.sharedInstance()?.signIn()
        
        //        if ((GIDSignIn.sharedInstance()?.hasPreviousSignIn()) != nil){
        //          GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        //          print("Already Login")
        //        }
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error{
            self.googlebtn.hideLoading()
            self.view.isUserInteractionEnabled = true
            print("\(error.localizedDescription)")
            CommonFunctions.toster(error.localizedDescription)
        }
        else {
            self.googlebtn.hideLoading()
            self.view.isUserInteractionEnabled = true
            // Perform any operations on signed in user here.
            // ...
            // let vc = tabbarVC.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
            // self.navigationController?.pushViewController(vc, animated: false)
            if user != nil{
                print(user.profile.email ?? "")
                print(user.profile.name ?? "")
                print(user.profile.familyName ?? "")
                print(user.profile.givenName ?? "")
                print(user.profile.hasImage)
                print(user.profile.imageURL(withDimension: 60) ?? "")
                print("Token is:-", user.authentication.accessToken ?? "")
            }
        }
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        CommonFunctions.toster(error.localizedDescription)
        self.view.isUserInteractionEnabled = true
        self.googlebtn.hideLoading()
    }
}
//MARK:- Facebook Login Btn Delegate
extension LoginVC: LoginButtonDelegate{
    func facebookLogin(){
        if let token = AccessToken.current, !token.isExpired {
            // User is logged in, do work such as go to next view controller.
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters:
                                                        ["fields": "email, name, first_name,last_name, middle_name,short_name, age_range,name_format, picture"], tokenString: token, version: nil, httpMethod: .get)
            request.start { (connetion, result, error) in
                print("\(result!)")
            }
        }else{
            faceBookBtn.permissions = ["public_profile", "email"]
            faceBookBtn.delegate = self
        }
    }
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters:
                                                    ["fields": "email, name, first_name,last_name, picture"], tokenString: token, version: nil, httpMethod: .get)
        request.start { (connetion, result, error) in
            print("\(String(describing: result))")
        }
    }
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logout")
    }
}

//MARK:- Apple Login Btn Delegate
extension LoginVC: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    @objc func appleBtnAction(_ sender: UIButton){
        //appleBtn.showLoading()
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName,.email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        //self.view.isUserInteractionEnabled = false
    }
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredentials = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredentials.user
            let fullName = appleIDCredentials.fullName
            let email = appleIDCredentials.email
            print(" User Identifier:- \(userIdentifier) Full Name:- \(String(describing: fullName))  Email:- \(String(describing: email)) ")
        }else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            let username = passwordCredential.user
            let password = passwordCredential.password
            print(username, password)
            DispatchQueue.main.async {
                self.showPasswordCredentialAlert(username: username, password: password)
            }
        }else{
            print("Error")
        }
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        //appleBtn.hideLoading()
        self.view.isUserInteractionEnabled = true
        CommonFunctions.toster(error.localizedDescription)
        debugPrint("error \(error)")
    }
    
    private func showPasswordCredentialAlert(username: String, password: String) {
        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
        let alertController = UIAlertController(title: "Keychain Credential Received", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
