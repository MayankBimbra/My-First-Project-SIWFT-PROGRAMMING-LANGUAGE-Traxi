//
//  failedpackageDeliveredPopupVC.swift
//  Traxi
//
//  Created by IOS on 06/04/21.
//

import UIKit


class failedpackageDeliveredPopupVC: UIViewController {
    //MARK:- Variables
    var cancellationId: Int?
    var cancellationReason: String?
    //MARK:- UI Components
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var deliveryView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var deliveryFailureLbl: UILabel!
    
    @IBOutlet weak var clientRefusedBtn: UIButton!
    @IBOutlet weak var clientRefusedImage: UIImageView!
    @IBOutlet weak var clientRefusedLbl: UILabel!
    
    @IBOutlet weak var clientUnavailabityLbl: UILabel!
    @IBOutlet weak var clientUnavailabityimage: UIImageView!
    @IBOutlet weak var clientUnavailabityBtn: UIButton!
    
    @IBOutlet weak var stuckIntrafficLbl: UILabel!
    @IBOutlet weak var stuckIntrafficImage: UIImageView!
    @IBOutlet weak var stuckIntrafficBtn: UIButton!
    
    @IBOutlet weak var inaccessibleLocLbl: UILabel!
    @IBOutlet weak var inaccessibleLocImage: UIImageView!
    @IBOutlet weak var inaccessibleLocBtn: UIButton!
    
    @IBOutlet weak var vehicleComplicationsLbl: UILabel!
    @IBOutlet weak var vehicleComplicationsimage: UIImageView!
    @IBOutlet weak var vehicleComplicationsBtn: UIButton!
    @IBOutlet weak var subitBtn: UIButton!
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        print(delivery_id!, dropoff_id!)
    }
    
    //MARK:- Btn Actions
    @objc func subitBtnAction(_ sender: UIButton){
        if cancellationId != nil {
            self.driverManagementAPI()
        }
        else {
            CommonFunctions.toster("Select a delivery failure reason first")
        }
    }
    //cancellation_id = 1
    @objc func clientRefusedBtnAction(_ sender: UIButton){
        self.fill(clientRefusedImage, lbl: clientRefusedLbl)
        self.defill([clientUnavailabityimage,stuckIntrafficImage,inaccessibleLocImage,vehicleComplicationsimage], label: [clientUnavailabityLbl,stuckIntrafficLbl,inaccessibleLocLbl,vehicleComplicationsLbl])
        cancellationId = 1
        cancellationReason = "Client Refused"
    }
    //cancellation_id = 2
    @objc func clientUnavailabityBtnAction(_ sender: UIButton){
        self.fill(clientUnavailabityimage, lbl: clientUnavailabityLbl)
        self.defill([clientRefusedImage,stuckIntrafficImage,inaccessibleLocImage,vehicleComplicationsimage], label: [clientRefusedLbl,stuckIntrafficLbl,inaccessibleLocLbl,vehicleComplicationsLbl])
        cancellationId = 2
        cancellationReason = "Client Unavailabilty"
    }
    //cancellation_id = 3
    @objc func stuckIntrafficBtnAction(_ sender: UIButton){
        self.fill(stuckIntrafficImage, lbl: stuckIntrafficLbl)
        self.defill([clientRefusedImage,clientUnavailabityimage,inaccessibleLocImage,vehicleComplicationsimage], label: [clientRefusedLbl,clientUnavailabityLbl,inaccessibleLocLbl,vehicleComplicationsLbl])
        cancellationId = 3
        cancellationReason = "Stuck in Traffic"
    }
    //cancellation_id = 4
    @objc func inaccessibleLocBtnAction(_ sender: UIButton){
        self.fill(inaccessibleLocImage, lbl: inaccessibleLocLbl)
        self.defill([clientRefusedImage,clientUnavailabityimage,stuckIntrafficImage,vehicleComplicationsimage], label: [clientUnavailabityLbl,clientRefusedLbl,stuckIntrafficLbl,vehicleComplicationsLbl])
        cancellationId = 4
        cancellationReason = "Inaccessible Location"
    }
    //cancellation_id = 5
    @objc func vehicleComplicationsBtnAction(_ sender: UIButton){
        self.fill(vehicleComplicationsimage, lbl: vehicleComplicationsLbl)
        self.defill([clientRefusedImage,clientUnavailabityimage,stuckIntrafficImage,inaccessibleLocImage], label: [clientUnavailabityLbl,clientRefusedLbl,stuckIntrafficLbl,inaccessibleLocLbl])
        cancellationId = 5
        cancellationReason = "Vehicle Complication"
    }
    
    @objc func cancelBtnAction(_ sender: UIButton){
        zoomOutAnimationHide()
        //self.dismiss(animated: false, completion: nil)
    }
    func fill(_ imageView: UIImageView, lbl: UILabel) {
        imageView.image =  UIImage(named: "radio_button_checked")
        imageView.tintColor = UIColor.ButtonGradientLightColor
        lbl.textColor = UIColor.ButtonGradientLightColor
    }
    
    func defill(_ imageView: [UIImageView], label: [UILabel]){
        for imgView in imageView {
            imgView.image =  UIImage(named: "radio_button_unchecked")
            imgView.tintColor = UIColor.black
        }
        for lbl in label {
            lbl.textColor = UIColor.black
        }
    }
}
//MARK:- Extension SetupUI
extension failedpackageDeliveredPopupVC {
    func setupUI(){
        myView.backgroundColor = UIColor(rgb: 0xFFF6C7)
        CommonFunctions.CornerRadius([], textViews: [], views: [myView,deliveryView], btns: [subitBtn])
        CommonFunctions.btnShadow(subitBtn)
        //zoomInAnimationShow()
        zoomOutAnimationShow()
        // Do any additional setup after loading the view.
        cancelBtn.addTarget(self, action: #selector(cancelBtnAction(_:)), for: .touchUpInside)
        clientRefusedBtn.addTarget(self, action: #selector(clientRefusedBtnAction(_:)), for: .touchUpInside)
        clientUnavailabityBtn.addTarget(self, action: #selector(clientUnavailabityBtnAction(_:)), for: .touchUpInside)
        stuckIntrafficBtn.addTarget(self, action: #selector(stuckIntrafficBtnAction(_:)), for: .touchUpInside)
        inaccessibleLocBtn.addTarget(self, action: #selector(inaccessibleLocBtnAction(_:)), for: .touchUpInside)
        vehicleComplicationsBtn.addTarget(self, action: #selector(vehicleComplicationsBtnAction(_:)), for: .touchUpInside)
        subitBtn.addTarget(self, action: #selector(subitBtnAction(_:)), for: .touchUpInside)
    }
}
//MARK:- Driver management APi Methods
extension failedpackageDeliveredPopupVC {
    func driverManagementAPI(){
        let params: [String: Any] =  [
            "cancel_delivery_id": delivery_id!,
            "dropoff_id": dropoff_id!,
            "cancellation_reason": self.cancellationReason as Any,
            "cancelled_id": self.cancellationId as Any,
            "distance_travelled": 0
        ]
        ApiHandler.callApiWithParameters(url: appConstantURL().driverManagementURL, withParameters: params, ofType: DriverManagementAPI.self, success2: { (response) in
            CommonFunctions.toster(response.message ?? "")
//            self.zoomOutAnimationHide()
//            self.navigationController?.popToRootViewController(animated: true)
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: tabbarVC.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
        }, failure: { (false, error) in
            CommonFunctions.toster(error)
        }, method: .PUT, img: nil, imageParamater: "", headerPresent: true)
    }
}


//MARK:- Popup Animations
extension failedpackageDeliveredPopupVC {
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
