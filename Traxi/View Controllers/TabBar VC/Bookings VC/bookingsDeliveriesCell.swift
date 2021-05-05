//
//  bookingsCell.swift
//  Traxi
//
//  Created by IOS on 30/03/21.
//

import UIKit

class bookingsDeliveriesCell: UITableViewCell {
    //MARK:- UI Components
    @IBOutlet weak var cellView: UIView!{
        didSet {
            CommonFunctions.CornerRadius([], textViews: [], views: [cellView], btns: [])
        }
    }
    @IBOutlet weak var dottedView: UIView!
    @IBOutlet weak var imgView: UIImageView!{
        didSet{
            imgView.layer.cornerRadius = imgView.frame.height / 2
        }
    }
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var moneyLbl: UILabel!
    @IBOutlet weak var singleDeliveryLbl: UILabel!
    @IBOutlet weak var ongoingLbl: UILabel!
    @IBOutlet weak var pickupDateLbl: UILabel!
    @IBOutlet weak var pickupDateDescriptionLbl: UILabel!
    @IBOutlet weak var pickupTimeLbl: UILabel!
    @IBOutlet weak var pickupTimeDescriptionLbl: UILabel!
    
    @IBOutlet weak var pickupPointLbl: UILabel!
    @IBOutlet weak var pickupadrressLbl: UILabel!
    @IBOutlet weak var pickupNameAddressPhoneLbl: UILabel!
   
    @IBOutlet weak var pickupPointTimeLbl: UILabel!
    @IBOutlet weak var dropoffPointLbl: UILabel!
    @IBOutlet weak var dropoffaddressLbl: UILabel!
    @IBOutlet weak var dropoffNameAddressPhoneLbl: UILabel!
    @IBOutlet weak var dropoffPointTimeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setData(_ data: Delivery, buttonSelected: Int, segmentControllerSelected: Int){
        nameLbl.text =  data.pickupDetails![0].userName
        moneyLbl.text = "$" + "\(data.deliveredCharges!)"
        
        if segmentControllerSelected == 1{
            self.ongoingLbl.text = "ONGOING"
            self.imgView.isHidden = false
        }
        else if segmentControllerSelected == 2{
            self.ongoingLbl.text = "DELIVERED"
            self.imgView.isHidden = true
        }
        else{
            ongoingLbl.text = "CANCELLED"
            imgView.isHidden = true
        }
//        To extract date and Time
        let fullDateAndTime = "\(data.pickupDetails![0].pickupDate!)"
        let (DATE,TIME) =  CommonFunctions.dateAndTime(fullDateAndTime)
        
        pickupDateDescriptionLbl.text = "\(DATE)"
        pickupTimeDescriptionLbl.text = "\(TIME)"
        pickupPointTimeLbl.text = "\(TIME)"
        dropoffPointTimeLbl.text = "\(TIME)"
        
        if data.deliverTypeID == 1{
            singleDeliveryLbl.text = "Single Delivery"
        }
        else if data.deliverTypeID == 2{
            singleDeliveryLbl.text = "Return Type"
        }
        else{
            singleDeliveryLbl.text = "Traxi Run"
        }
       
        pickupadrressLbl.text = data.pickupDetails![0].address ?? ""
        pickupNameAddressPhoneLbl.text = data.pickupDetails![0].userName! + ",(" + data.pickupDetails![0].userPhone! + ")," + data.pickupDetails![0].userApartment! + "," + data.pickupDetails![0].userLandmark!
        
        dropoffaddressLbl.text = data.dropoffDetails![0].address ?? ""
        dropoffNameAddressPhoneLbl.text = data.dropoffDetails![0].userName! + ",(" + data.dropoffDetails![0].userPhone! + ")," + data.dropoffDetails![0].userApartment! + "," + data.dropoffDetails![0].userLandmark!
        DispatchQueue.main.async {
            self.dottedView.createDottedLine(width: 2.0, color: UIColor.black.cgColor)
        }
    }
//    {
//        nameLbl.text = data.pickupDetails![0].userName
//        priceLbl.text = "$" + "\(data.deliveredCharges!)"
//        if data.timeSensitive! == 0{
//            timeFlexLbl.text = "Time Flexible"
//        }
//        else {
//            timeFlexLbl.text = "Time Sensitive"
//        }
//        //To extract date and Time
//        let fullDateAndTime = "\(data.pickupDetails![0].pickupDate!)"
//        let (DATE,TIME) =  CommonFunctions.dateAndTime(fullDateAndTime)
//
//       pickupDateLblDescription.text = "\(DATE)"
//       pickupTimeLblDescription.text = "\(TIME)"
//
//        pickupPointLblDescription.text = "\(data.pickupDetails![0].address!)"
//        dropOffPointLblDescription.text = "\(data.dropoffDetails![0].address!)"
//        if data.jobType == 1{
//            itemForPickupView.isHidden = true
//        }
//        else {
//            itemForPickupView.isHidden = false
//            itemsForPickupDescriptionLbl.text = "\(data.itemCount)"
//            ratingBtn.isHidden = false
//            // ratingLbl.isHidden = false
//           // ratingImage.isHidden = false
//           // ratingLbl.text = "\(data.storeRatings)"
//            ratingBtn.setTitle("\(data.storeRatings)", for: .normal)
//            imgView.layer.cornerRadius = imgView.frame.height / 2 - 15
//            nameLbl.text = data.name
//            deliveryLbl.textColor = UIColor.blue
//            deliveryLbl.addLeading(image: UIImage(named: "landmark")!, text: data.address ?? "")
//
//        }
//        if data.deliverTypeID == 1{
//            deliveryLbl.text = "Single Delivery"
//        }
//        else if data.deliverTypeID == 2{
//            deliveryLbl.text = "Return Type"
//        }
//        else{
//            deliveryLbl.text = "Traxi Run"
//        }
//
//        if data.dropoffDetails!.count == 1 {
//            dropOffPointLbl.text = "DROP OFF POINTS"
//            dropOffPointLblDescription.isHidden = false
//        }
//        else {
//            dropOffPointLbl.text = "\(data.dropoffDetails!.count) DROP OFF POINTS"
//           dropOffPointLblDescription.isHidden = true
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
//            self.dottedView.createDottedLine(width: 2.0, color: UIColor.black.cgColor)
//        })
//    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
