//
//  deliveredpackagePopupVC.swift
//  Traxi
//
//  Created by IOS on 05/04/21.
//

import UIKit

class deliveredpackagePopupVC: UIViewController {
    //MARK:- Variables
    var packageImage: String?
    let imagePicker = UIImagePickerController()
    //MARK:-  UI Components
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var uploadView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var uploadLbl: UILabel!
    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBOutlet weak var subitBtn: UIButton!
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
    }
    func imageUpload(_ img : UIImage){
        ApiHandler.callApiWithParameters(url: appConstantURL().uploadImageURL, withParameters: [:], ofType: UploadImageAPI.self, success2: { (response) in
            print(response)
            self.packageImage = response.filename
        }, failure: { (false, error) in
            print(error)
        }, method: .PostWithImage, img: img, imageParamater: "file", headerPresent: true)
    }
    //MARK:- Btn Actions
    @objc func cancelBtnAction(_ sender: UIButton){
        zoomOutAnimationHide()
        //self.dismiss(animated: false, completion: nil)
        // self.navigationController?.popViewController(animated: false)
    }
    @objc func subitBtnAction(_ sender: UIButton){
//        let story = UIStoryboard(name: "TabBar", bundle: Bundle.main)
//        let vc = story.instantiateViewController(withIdentifier: "deliverySuccessfulVC") as! deliverySuccessfulVC
//        vc.modalPresentationStyle = .fullScreen
//        self.navigationController?.pushViewController(vc, animated: true)
        if packageImage != nil {
            self.deliverymanagementAPI()
        }
        else {
            CommonFunctions.toster("Select the Package Image First")
        }
    }
}
//MARK:- SetupUI
extension deliveredpackagePopupVC{
    func setupUI(){
        myView.backgroundColor = UIColor(rgb: 0xFFF6C7)
        CommonFunctions.CornerRadius([], textViews: [], views: [myView,uploadView], btns: [subitBtn, addPhotoBtn])
        addPhotoBtn.clipsToBounds = true
        CommonFunctions.btnShadow(subitBtn)
        addPhotoBtn.layer.borderWidth = 1
        addPhotoBtn.layer.borderColor = UIColor(rgb: 0xE8C857).cgColor
        zoomInAnimationShow()
        //zoomOutAnimationShow()
        addPhotoBtn.addTarget(self, action: #selector(addPhotoBtnAction(_:)), for: .touchUpInside)
        subitBtn.addTarget(self, action: #selector(subitBtnAction(_:)), for: .touchUpInside)
        cancelBtn.addTarget(self, action: #selector(cancelBtnAction(_:)), for: .touchUpInside)
    }
    
}
//MARK:- delivery Management API
extension deliveredpackagePopupVC{
    func deliverymanagementAPI(){
        let params:[String: Any] = [
            "delivery_id": delivery_id!,
            "dropoff_id": dropoff_id!,
            "package_image": self.packageImage! as Any,
            "distance_travelled": distance_travelled!,
            "complete": 1 as Any
        ]
        ApiHandler.callApiWithParameters(url: appConstantURL().driverManagementURL, withParameters: params, ofType: DriverManagementAPI.self, success2: { (response) in
            CommonFunctions.toster(response.message ?? "")
            let story = UIStoryboard(name: "TabBar", bundle: Bundle.main)
            let vc = story.instantiateViewController(withIdentifier: "deliverySuccessfulVC") as! deliverySuccessfulVC
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }, failure: { (false, error) in
            CommonFunctions.toster(error)
        }, method: .PUT, img: nil, imageParamater: "", headerPresent: true)
    }
}

//MARK:- Image Picker Extension
extension deliveredpackagePopupVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @objc func addPhotoBtnAction(_ sender: UIButton){
        addPhotoBtn.isSelected = true
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
        imageUpload(tempImage)
        addPhotoBtn.setImage(tempImage, for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK:- Popup Animations
extension deliveredpackagePopupVC{
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
