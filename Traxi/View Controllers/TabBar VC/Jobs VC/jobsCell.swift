//
//  jobsCell.swift
//  Traxi
//
//  Created by IOS on 26/03/21.
//

import UIKit

class jobsCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ratingBtn: UIButton!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var ratingLbl: UILabel!
    
    @IBOutlet weak var deliveryLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var timeFlexLbl: UILabel!
    @IBOutlet weak var pickupDateLbl: UILabel!
    @IBOutlet weak var pickupDateLblDescription: UILabel!
    @IBOutlet weak var pickupTimeLbl: UILabel!
    @IBOutlet weak var pickupTimeLblDescription: UILabel!
    @IBOutlet weak var pickupPointLbl: UILabel!
    @IBOutlet weak var pickupPointLblDescription: UILabel!
    @IBOutlet weak var dropOffPointLbl: UILabel!
    @IBOutlet weak var dropOffPointLblDescription: UILabel!
    @IBOutlet weak var pickupCircleView: UIView!
    @IBOutlet weak var pickupCircleImage: UIImageView!
    @IBOutlet weak var dropOffPointView: UIView!
    @IBOutlet weak var dropOffPointImage: UIImageView!
    @IBOutlet weak var dottedView: UIView!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var itemsForPickupLbl: UILabel!
    @IBOutlet weak var itemsForPickupDescriptionLbl: UILabel!
    @IBOutlet weak var itemForPickupView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.layer.cornerRadius = imgView.frame.height / 2
        pickupCircleView.layer.cornerRadius = 5
        dropOffPointView.layer.cornerRadius = 5
        CommonFunctions.btnShadow(acceptBtn)
        CommonFunctions.CornerRadius([], textViews: [], views: [cellView], btns: [])
        ratingBtn.isHidden = true
        //ratingLbl.isHidden = true
        //ratingImage.isHidden = true
//        myClosure =  { (image) in
//            self.imgView.image = image
//        }
        
        //MARK: - - - - - Code for Passing Data through Notification Observer - - - - -
        // add observer in controller(s) where you want to receive data
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
    }
    
    //MARK: - - - - - Method for receiving Data through Post Notificaiton - - - - -
    @objc func methodOfReceivedNotification(notification: Notification) {
        print("Value of notification : ", notification.object ?? "")
        self.imgView.image = notification.userInfo?["image"] as! UIImage
      //  self.imgView.image = notification.object as? UIImage

    }
    func setData(_ data : Delivery){
        nameLbl.text = data.pickupDetails![0].userName
        priceLbl.text = "$" + "\(data.deliveredCharges!)"
        if data.timeSensitive! == 0{
            timeFlexLbl.text = "Time Flexible"
        }
        else {
            timeFlexLbl.text = "Time Sensitive"
        }
        //To extract date and Time
        let fullDateAndTime = "\(data.pickupDetails![0].pickupDate!)"
        let (DATE,TIME) =  CommonFunctions.dateAndTime(fullDateAndTime)
       
       pickupDateLblDescription.text = "\(DATE)"
       pickupTimeLblDescription.text = "\(TIME)"
        
        pickupPointLblDescription.text = "\(data.pickupDetails![0].address!)"
        dropOffPointLblDescription.text = "\(data.dropoffDetails![0].address!)"
        if data.jobType == 1{
            itemForPickupView.isHidden = true
        }
        else {
            itemForPickupView.isHidden = false
            itemsForPickupDescriptionLbl.text = "\(data.itemCount)"
            ratingBtn.isHidden = false
            // ratingLbl.isHidden = false
           // ratingImage.isHidden = false
           // ratingLbl.text = "\(data.storeRatings)"
            ratingBtn.setTitle("\(data.storeRatings)", for: .normal)
            imgView.layer.cornerRadius = imgView.frame.height / 2 - 15
            nameLbl.text = data.name
            deliveryLbl.textColor = UIColor.blue
            deliveryLbl.addLeading(image: UIImage(named: "landmark")!, text: data.address ?? "")
            
        }
        if data.deliverTypeID == 1{
            deliveryLbl.text = "Single Delivery"
        }
        else if data.deliverTypeID == 2{
            deliveryLbl.text = "Return Type"
        }
        else{
            deliveryLbl.text = "Traxi Run"
        }
        
        if data.dropoffDetails!.count == 1 {
            dropOffPointLbl.text = "DROP OFF POINTS"
            dropOffPointLblDescription.isHidden = false
        }
        else {
            dropOffPointLbl.text = "\(data.dropoffDetails!.count) DROP OFF POINTS"
           dropOffPointLblDescription.isHidden = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            self.dottedView.createDottedLine(width: 2.0, color: UIColor.black.cgColor)
        })
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
