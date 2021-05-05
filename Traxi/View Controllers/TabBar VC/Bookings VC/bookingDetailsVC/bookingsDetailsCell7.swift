//
//  bookingsDetailsCell7.swift
//  Traxi
//
//  Created by IOS on 08/04/21.
//

import UIKit
import DropDown

var delivery_id: Int?
var dropoff_id: Int?
var distance_travelled: String?

var userName: String?
var user_profile_image: String?
var userReviews: Int?
var userRated: Int?

class bookingsDetailsCell7: UITableViewCell {
    //MARK:- Variables
      var dropDown = DropDown()
    var controller: bookingsDetailVC?
    
    //MARK:- UI Components
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var distanceDescriptionLbl: UILabel!
    @IBOutlet weak var durationDescriptionLbl: UILabel!
    @IBOutlet weak var deliveryLbl: UILabel!
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBOutlet weak var dropDownAboveView: UIView!
    @IBOutlet weak var dropDownLbl: UILabel!
    @IBOutlet weak var dropDwonImageView: UIImageView!
    
    @IBOutlet weak var dropDownTopView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        CommonFunctions.CornerRadius([], textViews: [], views: [view], btns: [])
        dropDownBtn.addTarget(self, action: #selector(dropDownBtnAction(_:)), for: .touchUpInside)
    }
    //MARK:- Btn Action Functions
    @objc func dropDownBtnAction(_ sender: UIButton){
        CommonFunctions.dropDown(dropDwonImageView, dropDown: dropDown, sender: dropDownBtn, dataSource: ["Package Delivered","Delivery Failure"])
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            //sender.setTitle(item, for: .normal)
            self!.dropDownLbl.text = "\(item)"
            self!.dropDwonImageView.image = Asset.drop_down.image()
            if index == 0{
                let popOverVC = deliveredpackagePopupVC()
                self?.controller?.addChild(popOverVC)
                popOverVC.view.frame = (self!.controller?.view.frame)!
                self?.controller?.view.addSubview(popOverVC.view)
                self?.controller?.view.bringSubviewToFront(popOverVC.view)
                popOverVC.didMove(toParent: (self?.controller!))
//                let vc = deliveredpackagePopupVC(nibName: "deliveredpackagePopupVC", bundle: nil)
//                vc.deliveryId = self?.delivery_id
//                vc.dropoffId = self?.dropoff_id
//                vc.distanceTravelled = self?.distance_travelled
//                vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
////                self!.controller?.present(vc, animated: false)
//                let nav = UINavigationController(rootViewController: vc)
//                self!.controller?.present(nav, animated: true)
            }
            else if index == 1{
                let popOverVC = failedpackageDeliveredPopupVC()
                self?.controller?.addChild(popOverVC)
                popOverVC.view.frame = (self!.controller?.view.frame)!
                self?.controller?.view.addSubview(popOverVC.view)
                self?.controller?.view.bringSubviewToFront(popOverVC.view)
                popOverVC.didMove(toParent: (self?.controller!))
//                let vc = failedpackageDeliveredPopupVC(nibName: "failedpackageDeliveredPopupVC", bundle: nil)
//                vc.cancelDeliveryId = self?.delivery_id
//                vc.dropoffId = self?.dropoff_id
////                vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
////                self!.controller?.present(vc, animated: false)
//                let nav = UINavigationController(rootViewController: vc)
//                self!.controller?.present(nav, animated: true)
                
            }
        }
    }
    
    //MARK:- Set Data Method
    func setData(_ data: GetOrderDetailsAPI?, index: Int) {
        durationDescriptionLbl.text = data?.estimatedDeliveryTime ?? " "
        distanceDescriptionLbl.text = data?.distanceTravelled ?? " "
        delivery_id = data?.id ?? 0
        dropoff_id = data?.dropoffDetails[0].id ?? 0
        distance_travelled = data?.distanceTravelled ?? ""
        if data?.deliveryStatus ?? 0 == 2 {
            dropDownTopView.isHidden = false
        }
        else {
            dropDownTopView.isHidden = true
        }
        userName = data?.pickupDetails[0].userName ?? ""
        user_profile_image = data?.userProfileImage ?? ""
        userRated = data?.userRated ?? 0
        userReviews = data?.userReviews ?? 0
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
}
