//
//  bookingsDetailsCell1.swift
//  Traxi
//
//  Created by IOS on 08/04/21.
//

import UIKit
import Cosmos

class bookingsDetailsCell1: UITableViewCell {
    //MARK:- UI Components
    @IBOutlet weak var deliveryDetailsLbl: UILabel!
    @IBOutlet weak var deliveredLbl: UILabel!
    @IBOutlet weak var pickupDateLbl: UILabel!
    @IBOutlet weak var pickupTimeLbl: UILabel!
    @IBOutlet weak var pickupDateDescriptionLbl: UILabel!
    @IBOutlet weak var pickupTimeDescriptionLbl: UILabel!
    @IBOutlet weak var serviceTypeLbl: UILabel!
    @IBOutlet weak var requestTypeLbl: UILabel!
    @IBOutlet weak var serviceTypeDescriptionLbl: UILabel!
    @IBOutlet weak var requestTypeDescriptionLbl: UILabel!
    @IBOutlet weak var clientDetailsLbl: UILabel!
    @IBOutlet weak var clientNameLbl: UILabel!
    @IBOutlet weak var clientImageView: UIImageView!
    @IBOutlet weak var youRatedLbl: UILabel!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var deliveryCostLbl: UILabel!
    @IBOutlet weak var moneyLbl: UILabel!
    //MARK:-
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        clientImageView.layer.cornerRadius = clientImageView.frame.height / 2
    }
    //MARK:- Set data Fucntion
    func setData(_ data: GetOrderDetailsAPI?, index: Int){
        if data?.deliveryStatus == 2 {
            deliveredLbl.text = "ONGOING"
        }
        else if data?.deliveryStatus == 4 {
            deliveredLbl.text = "DELIVERED"
        }
        else{
            deliveredLbl.text = "CANCELLED"
        }
        
        if data?.deliverTypeID == 1{
            serviceTypeDescriptionLbl.text = "Single Delivery"
        }
        else if data?.deliverTypeID == 2{
            serviceTypeDescriptionLbl.text = "Return Type"
        }
        else{
            serviceTypeDescriptionLbl.text = "Traxi Run"
        }
        clientNameLbl.text = data?.pickupDetails[0].userName
        moneyLbl.text = "$" + "\(data?.deliveredCharges ?? 0)"
        if data?.timeSensitive! == 0{
            requestTypeDescriptionLbl.text = "Time Flexible"
        }
        else {
            requestTypeDescriptionLbl.text = "Time Sensitive"
        }
        //To extract date and Time
        if data?.pickupDetails[0].pickupDate != nil {
            let fullDateAndTime = data?.pickupDetails[0].pickupDate ?? ""
            let (DATE,TIME) =  CommonFunctions.dateAndTime(fullDateAndTime)
            pickupDateDescriptionLbl.text = "\(DATE)"
            pickupTimeDescriptionLbl.text = "\(TIME)"
        }
        cosmosView.isUserInteractionEnabled = false
        cosmosView.rating = Double(data?.userRated ?? 0)
        ratingLbl.text = String(data?.userRated ?? 0)
       // ratingLbl.text = String(cosmosView.rating)

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
