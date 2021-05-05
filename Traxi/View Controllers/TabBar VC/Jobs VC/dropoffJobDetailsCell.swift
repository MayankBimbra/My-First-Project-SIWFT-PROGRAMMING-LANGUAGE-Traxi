//
//  dropoffJobDetailsCell.swift
//  Traxi
//
//  Created by IOS on 06/04/21.
//

import UIKit

class dropoffJobDetailsCell: UITableViewCell {
    //MARK:- Variables
    var data: GetOrderDetailsAPI?
    var index: Int?
    //MARK:- UI Components
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var navigationBtn: UIButton!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var namePhoneAddressLbl: UILabel!
    @IBOutlet weak var dropoffPointImage: UIImageView!
    @IBOutlet weak var dropOffCircleView: UIView!
    @IBOutlet weak var dropOffCircleLbl: UILabel!
    @IBOutlet weak var dottedView: UIView!
    @IBOutlet weak var dottedView1: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dropOffCircleView.layer.cornerRadius = dropOffCircleView.frame.height / 2
        //  self.dottedView.createDottedLine(width: 2.0, color: UIColor.black.cgColor)
        //  self.dottedView1.createDottedLine(width: 2.0, color: UIColor.black.cgColor)
        callBtn.addTarget(self, action: #selector(callPickupBtnAction(_:)), for: .touchUpInside)
        navigationBtn.addTarget(self, action: #selector(navigationPickupBtnAction(_:)), for: .touchUpInside)
    }
    @objc func navigationPickupBtnAction(_ sender: UIButton){
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
            let url = (NSURL(string:                "comgooglemaps://?saddr=&daddr=\(data?.dropoffDetails[index!].lat ?? 0), \(data?.dropoffDetails[index!].lng ?? 0)&directionsmode=driving")! as URL)
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
 
        } else {
            CommonFunctions.toster("Can't use comgooglemaps:// -- Open in Real Device");
            //redirect to safari because the user doesn't have google map app
            UIApplication.shared.open(URL(string: "https://www.google.com/maps/")!)
        }
    }

    @objc func callPickupBtnAction(_ sender: UIButton){
        guard let number = URL(string: "tel://" + "\(data?.dropoffDetails[index!].userPhone ?? "")") else { return }
        if UIApplication.shared.canOpenURL(number){
            UIApplication.shared.open(number, options: [:] , completionHandler: nil)
        }else{
            CommonFunctions.toster("Call Facilities Not available! -- Open in Real Device")
        }
    }

    //MARK:- Set data Functions
    func setData(_ data: GetOrderDetailsAPI?, index: Int){
        self.data = data
        self.index = index
        
        dropOffCircleLbl.text = "\(index + 1)"
        addressLbl.text = data?.dropoffDetails[index].address ?? ""
        namePhoneAddressLbl.text = data!.dropoffDetails[index].userName! + ",(" + data!.dropoffDetails[index].userPhone! + ")," + data!.dropoffDetails[index].userApartment! + "," + data!.dropoffDetails[index].userLandmark!
        
        
        //single Delivery
        if data?.deliverTypeID == 1{
            dottedView.isHidden = true
            dottedView1.isHidden = true
            dropOffCircleView.isHidden = true
        }
        //Return Delivery
        else if data?.deliverTypeID == 2{
            dottedView.isHidden = true
            dottedView1.isHidden = true
            dropOffCircleView.isHidden = true
        }
        //Traxi run
        else {
            dottedView.isHidden = false
            dottedView1.isHidden = false
            dropOffCircleView.isHidden = false
        }
        
        DispatchQueue.main.async {
            self.dottedView1.createDottedLine(width: 2.0, color: UIColor.black.cgColor)
            self.dottedView.createDottedLine(width: 2.0, color: UIColor.black.cgColor)
        }
        
        //To hide Last dotted Line of a cell
        dottedView1.tag = index
        if dottedView1.tag == data!.dropoffDetails.count - 1 {
            dottedView1.isHidden = true
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
