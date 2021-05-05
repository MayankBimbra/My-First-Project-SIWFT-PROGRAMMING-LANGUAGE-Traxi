//
//  jobsDetailVC.swift
//  Traxi
//
//  Created by IOS on 02/04/21.
//

import UIKit
import DropDown

class jobsDetailVC: UIViewController {
    //MARK:- Variables
    var order_id: Int!
    var job_type: Int!
    var pickup_time: String?
    var estimated_time: String?
    var data: GetOrderDetailsAPI?
    var buttonSelected = 0
    //MARK:- UI Components
    @IBOutlet weak var pickupTableView: UITableView!
    @IBOutlet weak var pickupTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var dropoffTableView: UITableView!
    @IBOutlet weak var dropoffTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var itemsforPickupTableView: UITableView!
    @IBOutlet weak var itemsforPickupTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var jobsDetailHeaderView: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var nameRightRatingsBtn: UIButton!
    @IBOutlet weak var nameBelowratingBtn: UIButton!
    @IBOutlet weak var reviewLbl: UILabel!
    @IBOutlet weak var ratingReviewStackView: UIStackView!
    
    @IBOutlet weak var singleDeliveryLbl: UILabel!
    @IBOutlet weak var singleDeliveryLeftImage: UIImageView!
    @IBOutlet weak var moneyLbl: UILabel!
    @IBOutlet weak var timeFlexLbl: UILabel!
    
    @IBOutlet weak var pickupDateLbl: UILabel!
    @IBOutlet weak var pickupDateDescriptionLbl: UILabel!
    @IBOutlet weak var pickupTimeLbl: UILabel!
    @IBOutlet weak var pickupTimeDescriptionLbl: UILabel!
    @IBOutlet weak var packageTypeLbl: UILabel!
    @IBOutlet weak var packageTypeDescriptionLbl: UILabel!
    @IBOutlet weak var clientMessageLbl: UILabel!
    @IBOutlet weak var clientMesageDescriptionLbl: UILabel!
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var dropDownLbl: UILabel!
    @IBOutlet weak var itemForPickupLbl: UILabel!
    @IBOutlet weak var itemForPickupView: UIView!
    @IBOutlet weak var itemForPickupDescriptionLbl: UILabel!
    @IBOutlet weak var centreLine: UIView!
   
    @IBOutlet weak var priceItemTotalDeliveryChargesTotalView: UIView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var itemTotalLbl: UILabel!
    @IBOutlet weak var itemTotalDescriptionLbl: UILabel!
    @IBOutlet weak var DeliveryChargesLbl: UILabel!
    @IBOutlet weak var deliveryChargssDescriptionLbl: UILabel!
    @IBOutlet weak var taxAndChargeLbl: UILabel!
    @IBOutlet weak var taxAndChargeDescriptionLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var totalDescriptionLbl: UILabel!
    
    @IBOutlet weak var orderDetailsView: UIView!
    @IBOutlet weak var orderDetailsLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var dateDescriptionLbl: UILabel!
    @IBOutlet weak var deliveredLbl: UILabel!
    @IBOutlet weak var deliveredDescriptionNamePhoneNumberLbl: UILabel!
    @IBOutlet weak var deliveredDescriptionAddressLbl: UILabel!
    
    @IBOutlet weak var dropDownAboveView: UIView!
    @IBOutlet weak var dropDownImageView: UIImageView!
    @IBOutlet weak var deliveryStatusLbl: UILabel!
    @IBOutlet weak var acceptBtn: UIButton!{
        didSet{
            CommonFunctions.btnShadow(acceptBtn)
        }
    }
    @IBOutlet weak var dropOffPointLeftImage: UIImageView!{
        didSet {
            dropOffPointLeftImage.layer.cornerRadius = dropOffPointLeftImage.frame.height / 2 + 2
        }
    }
    @IBOutlet weak var dropOffPointLbl: UILabel!
    
    @IBOutlet weak var returnDeliveryView: UIView!
    @IBOutlet weak var returnDeliveryLbl: UILabel!
    @IBOutlet weak var pickUpCircleImageView: UIImageView!{
        didSet{
            pickUpCircleImageView.layer.cornerRadius = pickUpCircleImageView.frame.height / 2 + 2
        }
    }
    @IBOutlet weak var dropOffCircleImageView: UIImageView!{
        didSet{
            dropOffCircleImageView.layer.cornerRadius = dropOffCircleImageView.frame.height / 2 + 2
        }
    }
    @IBOutlet weak var pickupPointLbl: UILabel!
    @IBOutlet weak var pickUpaddressLbl: UILabel!
    @IBOutlet weak var pickupNamePhoneNumberLbl: UILabel!
    @IBOutlet weak var dropoffPointLbl: UILabel!
    @IBOutlet weak var dropOffAddressLbl: UILabel!
    
    @IBOutlet weak var dropOffNamePhoneNoLbl: UILabel!
    @IBOutlet weak var dottedreturnDeliveryView: UIView!
    //MARK:- Variables
    var dropDown = DropDown()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
}
//MARK:- Extension TableView Methods
extension jobsDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.itemsforPickupTableView{
            return 3
        }
        else if tableView == self.pickupTableView {
            return 1
        }
        else {
            if data?.deliverTypeID == 2 {
                return 1
            }
            else {
                return data?.dropoffDetails.count ?? 0
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.itemsforPickupTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemForPickupjobDetailsCell") as! itemForPickupjobDetailsCell
            cell.setData(data)
            return cell
        }
        else if tableView == self.pickupTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "pickupJobDetailsCell") as! pickupJobDetailsCell
            cell.setData(data, index: indexPath.row)
            return cell
        }
        else {
            let  cell = tableView.dequeueReusableCell(withIdentifier: "dropoffJobDetailsCell") as! dropoffJobDetailsCell
            cell.setData(data, index: indexPath.row)
            return cell
        }
    }
    
}
//MARK:- SetupUI
extension jobsDetailVC {
    func setupUI(){
        CommonFunctions.viewShadow(jobsDetailHeaderView)
        backBtn.addTarget(self, action: #selector(backBtnAction(_:)), for: .touchUpInside)
        dropDownBtn.addTarget(self, action: #selector(dropDownBtnAction(_:)), for: .touchUpInside)
        acceptBtn.addTarget(self, action: #selector(acceptBtnAction(_:)), for: .touchUpInside)
        if buttonSelected == 0{
            headerLbl.text = "Job Detail"
            topView.isHidden = true
            acceptBtn.isHidden = false
            callJobsAPI()
        }
        else {
            headerLbl.text = "Booking Details"
            packageTypeLbl.isHidden = true
            packageTypeDescriptionLbl.isHidden = true
            clientMessageLbl.isHidden = true
            clientMesageDescriptionLbl.isHidden = true
            topView.isHidden = false
            acceptBtn.isHidden = true
        }
        //self.setupApiData()
    }
    
    func setupApiData() {
        if (data?.dropoffDetails.count)! > 1{
            if (data?.pickupDetails.count)! > 1 {
            pickUpaddressLbl.text = data?.pickupDetails[1].address ?? ""
            pickupNamePhoneNumberLbl.text = data!.pickupDetails[1].userName! + ",(" + data!.pickupDetails[1].userPhone! + ")," + data!.pickupDetails[1].userApartment! + "," + data!.pickupDetails[1].userLandmark!
            
            dropOffAddressLbl.text = data?.dropoffDetails[1].address ?? ""
            dropOffNamePhoneNoLbl.text = data!.dropoffDetails[1].userName! + ",(" + data!.dropoffDetails[1].userPhone! + ")," + data!.dropoffDetails[1].userApartment! + "," + data!.dropoffDetails[1].userLandmark!
            }}
        
        //Package Type Description Label Content
        let count = data?.deliveryPackage.count ?? 0
        var array: [String] = []
        for index in 0..<count {
            array.append(data?.deliveryPackage[index].name ?? "")
        }
        let joined = array.joined(separator: " | ")
        packageTypeDescriptionLbl.text = joined
        
        clientMesageDescriptionLbl.text = data?.message
        nameLbl.text =  data?.userName ?? ""
        moneyLbl.text =  "$" + "\(data?.deliveredCharges ?? 0)"
        
        //To extract date and Time
        let fullDateAndTime = "\(data?.pickupDetails[0].pickupDate ?? "")"
        let (DATE,TIME) =  CommonFunctions.dateAndTime(fullDateAndTime)
        pickupDateDescriptionLbl.text = "\(DATE)"
        pickupTimeDescriptionLbl.text = "\(TIME)"
        
//        // Previous Approach To extract date and Time
//        let fullDateAndTime  = data?.pickupDetails[0].pickupDate ?? ""
//        let fullNameAndTimeArr = fullDateAndTime.components(separatedBy: " ")
//        let date = fullNameAndTimeArr[0]
//        let time = fullNameAndTimeArr[1]
//        pickupDateDescriptionLbl.text = date
//        pickupTimeDescriptionLbl.text = time
        
        //Single Delivery
        if data?.deliverTypeID == 1{
            singleDeliveryLbl.text = "Single Delivery"
            returnDeliveryView.isHidden = true
            dropOffPointLbl.text = "DROP OFF POINTS"
        }
        //Return delivery
        else if data?.deliverTypeID == 2{
            singleDeliveryLbl.text = "Return Delivery"
            returnDeliveryView.isHidden = false
            dropOffPointLbl.text = "DROP OFF POINTS"
        }
        //Traxi Run
        else{
            singleDeliveryLbl.text = "Traxi Run"
            returnDeliveryView.isHidden = true
            if data?.dropoffDetails.count == 1 {
                dropOffPointLbl.text = "DROP OFF POINTS"
            }
            else {
                dropOffPointLbl.text = "\(data?.dropoffDetails.count ?? 0 + 1) DROP OFF POINTS"
            }
        }
        if job_type == 1 {
            ratingReviewStackView.isHidden = true
            nameRightRatingsBtn.isHidden = true
            singleDeliveryLeftImage.isHidden = true
            profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
            itemForPickupView.isHidden = true
            itemsforPickupTableView.isHidden = true
            centreLine.isHidden = true
            priceItemTotalDeliveryChargesTotalView.isHidden = true
            orderDetailsView.isHidden = true
        }
        else {
            profileImageView.layer.cornerRadius = profileImageView.frame.height / 2 - 15
        }
        DispatchQueue.main.async {
            self.dottedreturnDeliveryView.createDottedLine(width: 2.0, color: UIColor.black.cgColor)

        }
    }
    //MARK:- Button Actions
    @objc func backBtnAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func acceptBtnAction(_ sender: UIButton){
        CommonFunctions.showLoader()
        let params: [String: Any] = [
            "delivery_id": self.order_id!,
            "job_type": self.job_type!,
            "pickup_time": self.pickup_time!,
            "estimated_time": self.estimated_time!
            ]
        ApiHandler.callApiWithParameters(url: appConstantURL().deliveryAcceptedURL, withParameters: params, ofType: DeliveryAcceptedAPI.self, success2: { (response) in
            CommonFunctions.hideLoader()
            CommonFunctions.toster(response.message ?? "")
            self.callJobsAPI()
            self.navigationController?.popViewController(animated: true)
        }, failure: { (false, error) in
            print(error)
            CommonFunctions.hideLoader()
        }, method:.PUTWithJSON, img: nil, imageParamater: "", headerPresent: true)
    }
    @objc func dropDownBtnAction(_ sender: UIButton){
        CommonFunctions.dropDown(dropDownImageView, dropDown: dropDown, sender: dropDownBtn, dataSource: ["Package Delivered","Delivery Failure"])
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            //sender.setTitle(item, for: .normal)
            self!.dropDownLbl.text = "\(item)"
            self!.dropDownImageView.image = Asset.drop_down.image()
            if index == 0{
                let vc = deliveredpackagePopupVC(nibName: "deliveredpackagePopupVC", bundle: nil)
                vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                self?.navigationController?.pushViewController(vc, animated: false)
                //self!.present(vc, animated: false)
                
            }
            else if index == 1{
                let vc = failedpackageDeliveredPopupVC(nibName: "failedpackageDeliveredPopupVC", bundle: nil)
                vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                self!.present(vc, animated: false)
                
            }
        }
    }
}

//MARK:- API Methods
extension jobsDetailVC {
    func callJobsAPI(){
        let params:[String:Any] = [:]
        let link = appConstantURL().getOrderDetailsURL + "?order_id=" + "\(order_id!)" + "&job_type=" + "\(job_type!)"
        CommonFunctions.showLoader()
        
        ApiHandler.callApiWithParameters(url: link, withParameters: params, ofType: GetOrderDetailsAPI.self, success2: { (response) in
            self.data = response
            self.setupApiData()
            self.itemsforPickupTableView.reloadData()
            self.pickupTableView.reloadData()
            self.dropoffTableView.reloadData()
            CommonFunctions.hideLoader()
            
        }, failure: { (reload, error) in
            CommonFunctions.hideLoader()
            CommonFunctions.toster(error)
        }, method: .GET, img: nil, imageParamater: "", headerPresent: true)
    }
}


//MARK:- Tableview Height Calculation Methods
extension jobsDetailVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.pickupTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.dropoffTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.itemsforPickupTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.pickupTableView.reloadData()
        self.dropoffTableView.reloadData()
        self.itemsforPickupTableView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.pickupTableView.removeObserver(self, forKeyPath: "contentSize")
        self.dropoffTableView.removeObserver(self, forKeyPath: "contentSize")
        self.itemsforPickupTableView.removeObserver(self, forKeyPath: "contentSize")
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let obj = object as? UITableView {
            if obj == self.pickupTableView && keyPath == "contentSize" {
                if let newSize = change?[NSKeyValueChangeKey.newKey] as? CGSize {
                    self.pickupTableViewHeight.constant = newSize.height
                }
            }
            if obj == self.dropoffTableView && keyPath == "contentSize" {
                if let newSize = change?[NSKeyValueChangeKey.newKey] as? CGSize {
                    self.dropoffTableViewHeight.constant = newSize.height
                }
            }
            if obj == self.itemsforPickupTableView && keyPath == "contentSize" {
                if let newSize = change?[NSKeyValueChangeKey.newKey] as? CGSize {
                    self.itemsforPickupTableViewHeight.constant = newSize.height
                }
            }
        }
    }
}
