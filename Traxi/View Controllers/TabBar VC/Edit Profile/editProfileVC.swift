//
//  editProfileVC.swift
//  Traxi
//
//  Created by IOS on 30/03/21.
//

import UIKit
import SkyFloatingLabelTextField
import YYWebImage

//protocol editProfileVCDelegate {
//    func  didChange (_ profile: GetProfileAPI?)
//}
struct dataStruct {
    var image: String?
    var name: String?
    var email: String?
    var phoneNumber: String?
    var password: String?
}



class editProfileVC: UIViewController {
    //MARK:- Variables
    var data : [dataStruct] = []
    let imagePicker = UIImagePickerController()
    var imageName: String?
    //closures is also like a function, in it the arguments are in the first bracket and the return
    var myClosure: ((_ image: UIImage)-> Void)?
  //  var delegate: editProfileVCDelegate?
    
    //MARK:- UI Components
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgPickerBtn: UIButton!
    @IBOutlet weak var editNameBtn: UIButton!
    @IBOutlet weak var editNameBtnView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var saveNameBtn: UIButton!
    @IBOutlet weak var saveNameBtnView: UIView!
    @IBOutlet weak var nameTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailTF: SkyFloatingLabelTextField!
    @IBOutlet weak var saveEmailBtnView: UIView!
    @IBOutlet weak var saveEmailBtn: UIButton!
    @IBOutlet weak var editEmailBtnView: UIView!
    @IBOutlet weak var editEmailBtn: UIButton!
    
    
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var editPhoneBtnView: UIView!
    @IBOutlet weak var editPhoneBtn: UIButton!
    @IBOutlet weak var savePhoneBtnView: UIView!
    @IBOutlet weak var savePhoneBtn: UIButton!
    @IBOutlet weak var phoneTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var editPasswordBtnView: UIView!
    @IBOutlet weak var editPasswordBtn: UIButton!
    @IBOutlet weak var savePasswordBtnView: UIView!
    @IBOutlet weak var savePasswordBtn: UIButton!
    @IBOutlet weak var passwordTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var headerSettingsView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var phoneNoView: UIView!
    @IBOutlet weak var passwordView: UIView!
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.addTarget(self, action: #selector(backBtnAction(_:)), for: .touchUpInside)
    
        editNameBtn.addTarget(self, action: #selector(editNameBtnAction(_:)), for: .touchUpInside)
        saveNameBtn.addTarget(self, action: #selector(saveNameBtnAction(_:)), for: .touchUpInside)
        
        editEmailBtn.addTarget(self, action: #selector(editEmailBtnAction(_:)), for: .touchUpInside)
        saveEmailBtn.addTarget(self, action: #selector(saveEmailBtnAction(_:)), for: .touchUpInside)
        
        editPhoneBtn.addTarget(self, action: #selector(editPhoneNumberBtnAction(_:)), for: .touchUpInside)
        savePhoneBtn.addTarget(self, action: #selector(savePhoneNumberBtnAction(_:)), for: .touchUpInside)
        
        editPasswordBtn.addTarget(self, action: #selector(editPasswordBtnAction(_:)), for: .touchUpInside)
        savePasswordBtn.addTarget(self, action: #selector(savePasswordBtnAction(_:)), for: .touchUpInside)
        
        editProfileVC.hiddenTrue([nameTF,emailTF,phoneTF,passwordTF],
                                  [saveNameBtnView,saveEmailBtnView,savePhoneBtnView,savePasswordBtnView])
        CommonFunctions.CornerRadius([], textViews: [], views: [nameView, emailView, phoneNoView, passwordView], btns: [])
        CommonFunctions.viewShadow(headerSettingsView)
        CommonFunctions.CornerRadius([], textViews: [], views: [], btns: [saveNameBtn, saveEmailBtn, savePhoneBtn, savePasswordBtn])
        imgView.layer.cornerRadius = self.imgView.frame.height / 2
        imgPickerBtn.layer.cornerRadius = self.imgPickerBtn.frame.height / 2
        imgPickerBtn.addTarget(self, action: #selector(uploadImages(_ :)), for: .touchUpInside)
        
      //  self.nameTF.frame.size.height = 45
        nameTF.delegate = self
        emailTF.delegate = self
        
        self.nameLbl.text = coreData.shared.name
        self.phoneLbl.text = "\(coreData.shared.phoneNumber )"
        self.emailLbl.text = coreData.shared.email
        
        self.imgView.yy_setImage(with: URL(string: CommonFunctions.getImage(coreData.shared.profileImage , quality: .large)), placeholder: UIImage(named: ""))
        
        imageName = coreData.shared.profileImage
        //self.getProfile()
        
    }
   
    
    //MARK:- Life Cycle
    @objc func backBtnAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Functions
    func checkValidations(_ tf: UITextField){
        if tf.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            tf.shake()
            CommonFunctions.toster("Please Enter Empty Details")
        }
        else{
            editProfileAPI()
        }
    }
    //MARK:- To hide tfs and views
    static func hiddenTrue(_ tfs: [UITextField], _ views: [UIView]){
        for tf in tfs {
            tf.isHidden = true
        }
        for view in views {
            view.isHidden = true
        }
    }
    // MARK: - ForgotAPI
    func editProfileAPI(){
        self.view.endEditing(true)
        var params : [String : Any] = [:]
       
        if imageName != nil {
            params = ["profile_image" : imageName!]
         }
        
        if saveNameBtn.isSelected == true {
             params = ["name" : nameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""]
        }
        if saveEmailBtn.isSelected == true {
            params = ["email" : emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""]
        }
        if savePhoneBtn.isSelected == true {
            params = ["phone" : phoneTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""]
        }
       

        view.isUserInteractionEnabled = false

        ApiHandler.callApiWithParameters(url: appConstantURL().editProfileURL, withParameters: params, ofType: EditProfileAPI.self, success2: { (response) in
            print(response)
            CommonFunctions.toster(response.message!)
            self.view.isUserInteractionEnabled = true
            self.nameTF.text = ""
            coreData.shared.profileImage = self.imageName ?? ""
            coreData.shared.name = self.nameLbl.text!
            coreData.shared.phoneNumber = Int(self.phoneLbl.text!)!
            coreData.shared.dataSave()
//           self.getProfile()
         }, failure: { (reload, error) in
            self.view.isUserInteractionEnabled = true
            if reload{
                self.editProfileAPI()
            }else{
                CommonFunctions.toster(error)
            }
        }, method: .PUTWithJSON, img: nil, imageParamater: "", headerPresent: true)
    }
    //MARK:- Actions Objective Functions
    @objc func editNameBtnAction(_ sender: UIButton){
        editNameBtnView.isHidden = true
        nameLbl.isHidden = true
        saveNameBtnView.isHidden = false
        nameTF.isHidden = false
        nameTF.text = nameLbl.text
    }
    @objc func saveNameBtnAction(_ sender: UIButton){
        if !(nameTF.text!.isEmpty) {
            saveNameBtn.isSelected = true
            editNameBtnView.isHidden = false
            saveNameBtnView.isHidden = true
            nameLbl.isHidden = false
            nameTF.isHidden = true
            data.insert(dataStruct(image: nil, name: nameTF.text, email: nil, phoneNumber: nil, password: nil), at: 0)
            self.nameLbl.text =  data[0].name
            checkValidations(nameTF)
        }
        else {
            CommonFunctions.toster("Name cannot be empty")
        }
    }
    //Email
    @objc func editEmailBtnAction(_ sender: UIButton){
        editEmailBtnView.isHidden = true
        emailLbl.isHidden = true
        saveEmailBtnView.isHidden = false
        emailTF.isHidden = false
        emailTF.text = emailLbl.text
    }
    @objc func saveEmailBtnAction(_ sender: UIButton){
        if !(emailTF.text!.isEmpty) {
        saveEmailBtn.isSelected = true
        emailLbl.isHidden = false
        emailTF.isHidden = true
        editEmailBtnView.isHidden = false
        saveEmailBtnView.isHidden = true
        data.insert(dataStruct(image: nil, name: nil, email: emailTF.text, phoneNumber: nil, password: nil), at: 0)
        self.emailLbl.text =  data[0].email
        checkValidations(emailTF)
        }
        else {
            CommonFunctions.toster("Email cannot be empty")
        }
    
    }
    //Phone number
    @objc func editPhoneNumberBtnAction(_ sender: UIButton){
        editPhoneBtnView.isHidden = true
        phoneLbl.isHidden = true
        savePhoneBtnView.isHidden = false
        phoneTF.isHidden = false
        phoneTF.text = phoneLbl.text
        
    }
    @objc func savePhoneNumberBtnAction(_ sender: UIButton){
        if !(phoneTF.text!.isEmpty) {
            savePhoneBtn.isSelected = true
            phoneLbl.isHidden = false
            phoneTF.isHidden = true
            editPhoneBtnView.isHidden = false
            savePhoneBtnView.isHidden = true
            data.insert(dataStruct(image: nil, name: nil, email: nil, phoneNumber: phoneTF.text, password: nil), at: 0)
            self.phoneLbl.text =  data[0].phoneNumber
            checkValidations(phoneTF)
        }
        else {
            CommonFunctions.toster("Phone Number cannot be empty")
        }
        
    }
      //Password
    @objc func editPasswordBtnAction(_ sender: UIButton){
        let popOverVC = changePswPopupVC()
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
        
        editPasswordBtnView.isHidden = false
        passwordLbl.isHidden = false
        savePasswordBtnView.isHidden = true
        passwordTF.isHidden = true
//        editPasswordBtnView.isHidden = true
//        passwordLbl.isHidden = true
//        savePasswordBtnView.isHidden = false
//        passwordTF.isHidden = false
    }
    @objc func savePasswordBtnAction(_ sender: UIButton){
        editPasswordBtnView.isHidden = false
        savePasswordBtnView.isHidden = true
        passwordLbl.isHidden = false
        passwordTF.isHidden = true
    }
}
//MARK:- Image Picker Extension
extension editProfileVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    @objc func uploadImages(_ sender: UIButton) {
        imgPickerBtn.isSelected = true
        let alert = UIAlertController(title: "Photo Source", message: "Select the Photo Source", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Camera", style: .default, handler: { (UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.sourceType = .camera;
                self.imagePicker.allowsEditing = false
                self.imagePicker.modalPresentationStyle = UIModalPresentationStyle.currentContext
                self.imagePicker.delegate = self
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        })
        let action1 = UIAlertAction(title: "Photo Library", style: .default, handler: { (UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.imagePicker.sourceType = .photoLibrary;
                self.imagePicker.allowsEditing = true
                self.imagePicker.modalPresentationStyle = UIModalPresentationStyle.currentContext
                self.imagePicker.delegate = self
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        })
        let action2 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
     //   data.insert(dataStruct(image: tempImage, name: nil, email: nil, phoneNumber: nil, password: nil), at: 0)
    
       // self.imgView.image = data[0].image!
        self.imgView.image = tempImage
        imageUpload(tempImage)
        
        //MARK:- Using Closure
       // myClosure?(tempImage)
        
        //MARK: - - - - - Set data for Passing Data Post Notification - - - - -
        //dictionary objToBeSent
        let phoneNumer: Int = 666665876895
        let objToBeSent:[String: Any] = ["image": tempImage, "phoneNumber": phoneNumer]
        //let objToBeSent = tempImage
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil, userInfo: objToBeSent)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension editProfileVC{
    //Image Upload
    func imageUpload(_ img : UIImage){
        ApiHandler.callApiWithParameters(url: appConstantURL().uploadImageURL, withParameters: [:], ofType: UploadImageAPI.self, success2: { (profileAPI) in
            print(profileAPI)
            self.imageName = profileAPI.filename
            CommonFunctions.toster(profileAPI.message!)
            self.editProfileAPI()
            print(self.imageName!)
        }, failure: { (false, string) in
            print(string)
        }, method: ApiMethod.PostWithImage, img: img, imageParamater: "file", headerPresent: true)
    }
    
//    func getProfile() {
//        let params : [String: String] = [:]
//        CommonFunctions.showLoader()
//
//        ApiHandler.callApiWithParameters(url: appConstantURL().signUpURL, withParameters: params, ofType: GetProfileAPI.self, success2: { (response) in
//            print(response)
//           // self.delegate?.didChange(response)
//
////            self.imgView.yy_setImage(with: URL(string: CommonFunctions.getImage(response.profileImage ?? "", quality: .large)), placeholder: UIImage(named: ""))
////             self.nameLbl.text = response.name ?? ""
////            self.phoneLbl.text = "\(response.phone ?? 0)"
////            self.emailLbl.text = response.email ?? ""
//
//            CommonFunctions.hideLoader()
////            imageName = response.profileImage ?? ""
//
//        }, failure: { (false, string) in
//            print(string)
//            CommonFunctions.hideLoader()
//
//        }, method: ApiMethod.GET , img: nil, imageParamater: "", headerPresent: true)
//    }
}

extension editProfileVC: UITextFieldDelegate {
    func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 100, dy: 100);
    }

    func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 10);
    }
}
