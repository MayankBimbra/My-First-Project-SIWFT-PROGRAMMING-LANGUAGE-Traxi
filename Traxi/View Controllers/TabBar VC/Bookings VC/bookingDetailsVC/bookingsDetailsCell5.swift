//
//  bookingsDetailsCell5.swift
//  Traxi
//
//  Created by IOS on 08/04/21.
//

import UIKit

class bookingsDetailsCell5: UITableViewCell {
    //MARK:- UI Components
    @IBOutlet weak var dottedView: UIView!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var circleImage: UIImageView!
    @IBOutlet weak var circleLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var nameAddressPhoneLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    //MARK:- Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        circleView.layer.cornerRadius = circleView.frame.height / 2
    }
    //MARK:- SetData Fucntion
    func setData(_ data: GetOrderDetailsAPI?, index: Int) {
        addressLbl.text = data!.dropoffDetails[index].address
        nameAddressPhoneLbl.text = data!.dropoffDetails[index].userName! + ",(" + data!.dropoffDetails[index].userPhone! + ")," + data!.dropoffDetails[index].userApartment! + "," + data!.dropoffDetails[index].userLandmark!
        //To extract date and Time
        let fullDateAndTime = "\(data!.pickupDetails[0].pickupDate!)"
        let (_,TIME) =  CommonFunctions.dateAndTime(fullDateAndTime)
        timeLbl.text = "\(TIME)"
        
     
        if data!.dropoffDetails.count == index + 1 {
           dottedView.isHidden = true
        }
        //Single Delivery
        if data!.deliverTypeID == 1{
            circleView.isHidden = true
        }
        else {
            circleView.isHidden = false
        }
        DispatchQueue.main.async {
            self.dottedView.createDottedLine(width: 2.0, color: UIColor.black.cgColor)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
