//
//  bookingsDetailsCell3.swift
//  Traxi
//
//  Created by IOS on 08/04/21.
//

import UIKit

class bookingsDetailsCell3: UITableViewCell {
    
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var addressNamePhoneLbl: UILabel!
    @IBOutlet weak var dottedView: UIView!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var circleImageView: UIImageView!
    @IBOutlet weak var circleLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        circleView.layer.cornerRadius = circleView.frame.height / 2
       // self.dottedView.createDottedLine(width: 2.0, color: UIColor.black.cgColor)
    }
    func setData(_ data: GetOrderDetailsAPI?, index: Int) {
        addressLbl.text = data!.pickupDetails[index].address
        addressNamePhoneLbl.text = data!.pickupDetails[index].userName! + ",(" + data!.pickupDetails[index].userPhone! + ")," + data!.pickupDetails[index].userApartment! + "," + data!.pickupDetails[index].userLandmark!
           
        //To extract date and Time
        let fullDateAndTime = "\(data!.pickupDetails[index].pickupDate!)"
        let (_,TIME) =  CommonFunctions.dateAndTime(fullDateAndTime)
        timeLbl.text = "\(TIME)"
        
        if data!.deliverTypeID == 1{
            //deliveryLbl.text = "Single Delivery"
            circleImageView.isHidden = true
            circleLbl.isHidden = true
            let view = UIView(frame: CGRect(x: 9, y: 4, width: 5.0, height: 15))
            view.createDottedLine(width: 2.0, color: UIColor.black.cgColor)
            circleView.backgroundColor = .clear
            circleView.addSubview(view)
        }
        else if data!.deliverTypeID == 2{
            //deliveryLbl.text = "Return Type"
            circleView.isHidden = false
        }
        else{
            //deliveryLbl.text = "Traxi Run"
            circleImageView.isHidden = true
            circleLbl.isHidden = true
            let view = UIView(frame: CGRect(x: 9, y: 4, width: 5.0, height: 15))
            view.createDottedLine(width: 2.0, color: UIColor.black.cgColor)
            circleView.backgroundColor = .clear
            circleView.addSubview(view)
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
