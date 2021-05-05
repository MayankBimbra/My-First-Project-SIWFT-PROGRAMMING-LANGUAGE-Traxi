//
//  jobDetailsCell.swift
//  Traxi
//
//  Created by IOS on 05/04/21.
//

import UIKit

class pickupJobDetailsCell: UITableViewCell {
    //MARK:- Variables
    var yourobj : (() -> Void)? = nil
    var data: GetOrderDetailsAPI?
    var index: Int?
    //MARK:- UI COMPONENTS
    @IBOutlet weak var dottedView: UIView!
    @IBOutlet weak var navigationPickupBtn: UIButton!
    @IBOutlet weak var callPickupBtn: UIButton!
    @IBOutlet weak var pickupPointImage: UIImageView!
    @IBOutlet weak var pickupPointLbl: UILabel!
    @IBOutlet weak var pickupAddressLbl: UILabel!
    @IBOutlet weak var pickupNamePhoneAddressLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pickupPointImage.layer.cornerRadius = pickupPointImage.frame.height / 2 + 2
        callPickupBtn.addTarget(self, action: #selector(callPickupBtnAction(_:)), for: .touchUpInside)
        navigationPickupBtn.addTarget(self, action: #selector(navigationPickupBtnAction(_:)), for: .touchUpInside)
    }
    
    @objc func navigationPickupBtnAction(_ sender: UIButton){
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
            let url = (NSURL(string:                "comgooglemaps://?saddr=&daddr=\(data?.pickupDetails[index!].lat ?? 0), \(data?.pickupDetails[index!].lng ?? 0)&directionsmode=driving")! as URL)
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
 
        } else {
            CommonFunctions.toster("Can't use comgooglemaps:// -- Open in Real Device");
            //redirect to safari because the user doesn't have goolge map app
            UIApplication.shared.open(URL(string: "https://www.google.com/maps/")!)
        }
    }

    @objc func callPickupBtnAction(_ sender: UIButton){
        guard let number = URL(string: "tel://" + "\(data?.pickupDetails[index!].userPhone ?? "")") else { return }
        if UIApplication.shared.canOpenURL(number){
            UIApplication.shared.open(number, options: [:] , completionHandler: nil)
        }else{
            CommonFunctions.toster("Call Facilities Not available! -- Open in Real Device")
        }
    }
    //MARK:- Set data Function
    func setData(_ data: GetOrderDetailsAPI?, index: Int){
        self.data = data
        self.index =  index
        //Single delivery
        if data?.deliverTypeID == 1{
            pickupAddressLbl.text = data?.pickupDetails[0].address ?? ""
        }
        //return type
        else if data?.deliverTypeID == 2{
            pickupAddressLbl.text = data?.pickupDetails[0].address ?? ""
            
        }
        //Traxi run
        else{
            pickupAddressLbl.text = data?.pickupDetails[0].address ?? ""
        }
        if data == nil {
            pickupNamePhoneAddressLbl.text = ""
        }
        else{
            pickupNamePhoneAddressLbl.text = data!.pickupDetails[0].userName! + ",(" + data!.pickupDetails[0].userPhone! + ")," + data!.pickupDetails[0].userApartment! + "," + data!.pickupDetails[0].userLandmark!
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
