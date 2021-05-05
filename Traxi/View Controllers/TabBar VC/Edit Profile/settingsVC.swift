//
//  settingsVC.swift
//  Traxi
//
//  Created by IOS on 30/03/21.
//

import UIKit

class settingsVC: UIViewController {
    //MARK:- Variables
    
    //MARK:- UI Components
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var contactUsBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var headerSettingsView: UIView!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        coreData.shared.getData()
        self.nameLbl.text = coreData.shared.name
        self.phoneNumberLbl.text = "\(coreData.shared.phoneNumber)"
       //MARK: - - - - - Code for Passing Data through Notification Observer - - - - -
        // add observer in controller(s) where you want to receive data
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
    }
  
//    override func viewDidDisappear(_ animated: Bool) {
//        NotificationCenter.default.removeObserver(self, name: Notification.Name("NotificationIdentifier"), object: nil)
//    }
    //MARK: - - - - - Method for receiving Data through Post Notificaiton - - - - -
    @objc func methodOfReceivedNotification(notification: Notification) {
        print("Value of notification : ", notification.object ?? "")
        if let image = notification.userInfo?["image"] as? UIImage {
          // do something with your image
            self.imgView.image = image
          }
        //phoneNumberLbl.text = String(notification.userInfo?["phoneNumber"] as! Int)
        //self.imgView.image = notification.object as? UIImage
    }
    //MARK:- Button Actions
    @objc func editBtnAction(_ sender : UIButton){
        let vc = storyboard?.instantiateViewController(identifier: "editProfileVC") as! editProfileVC
        // vc.delegate  = self
        //        vc.myClosure =  { (image) in
        //            self.imgView.image = image
        //        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func contactUsBtnAction(_ sender : UIButton){
        let vc = storyboard?.instantiateViewController(identifier: "contactUsVC") as! contactUsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func logOutBtnAction(_ sender : UIButton){
        let alert = UIAlertController(title: "WANT TO LOG OUT?", message: "Sure?", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "NO", style: .cancel, handler: nil)
        let alertAction1 = UIAlertAction(title: "YES", style: .destructive) { _ in
            self.logoutAPI()
            CommonFunctions.logout()
        }
        alert.addAction(alertAction)
        alert.addAction(alertAction1)
        self.present(alert, animated: true, completion: nil)
    }
}
//MARK:-  Setup API
extension settingsVC {
    func setupUI() {
        editBtn.addTarget(self, action: #selector(editBtnAction(_:)), for: .touchUpInside)
        logoutBtn.addTarget(self, action: #selector(logOutBtnAction(_:)), for: .touchUpInside)
        contactUsBtn.addTarget(self, action: #selector(contactUsBtnAction(_:)), for: .touchUpInside)
        imgView.layer.cornerRadius = self.imgView.frame.height / 2
        CommonFunctions.viewShadow(headerSettingsView)
        self.imgView.yy_setImage(with: URL(string: CommonFunctions.getImage(coreData.shared.profileImage , quality: .large)), placeholder: UIImage(named: ""))
    }
}
//MARK:- Log out API
extension settingsVC {
    //LOG OUT
    func logoutAPI() {
        let params: [String:Any] = [:]
        ApiHandler.callApiWithParameters(url: appConstantURL().logoutURL, withParameters: params, ofType: LogOutAPI.self, success2: { (response) in
            print(response)
            coreData.shared.deleteData()
            CommonFunctions.toster(response.message ?? "")
        }, failure: { (reload,error) in
            if reload{
                self.logoutAPI()
            }else{
                CommonFunctions.toster(error)
            }
        }, method: .PUTWithJSON, img: nil, imageParamater: "", headerPresent: true)
    }
}

//MARK:- Delegate method
//extension settingsVC: editProfileVCDelegate {
//  func didChange(_ profile: GetProfileAPI?) {
//    self.nameLbl.text = profile?.name
//    }
//}
