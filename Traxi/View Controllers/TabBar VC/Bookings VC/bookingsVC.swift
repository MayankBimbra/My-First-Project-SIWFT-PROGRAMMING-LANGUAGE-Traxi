//
//  bookingsVC.swift
//  Traxi
//
//  Created by IOS on 30/03/21.
//

import UIKit
import DropDown
import ESPullToRefresh

class bookingsVC: UIViewController {
    //MARK:- Variables
    let spinner = UIActivityIndicatorView(style: .gray)

    let dropDown = DropDown()
    var buttonSelected = 0
    var segmentedControllerSelected = 1
    
    var job_type: Int?
    var data: [Delivery] = []
    var status: Int = 2 // 2- Upcoming, 4- Completed, 6- Cancelled
    var sorting: Int = 4
    var pageNumber: Int = 1
    var limit: Int = 10
    
    //Pagination
    var canPagination: Bool = true
    var IsApiHitting: Bool = false
    var IsApiHitOnce: Bool = false
    
    //MARK:- UI Components
    @IBOutlet weak var deliveriesBtn: UIButton!
    @IBOutlet weak var deliveriesImageView: UIImageView!
    @IBOutlet weak var deliveriesLbl: UILabel!
    @IBOutlet weak var deliveriesView: UIView!
    
    @IBOutlet weak var storesBtn: UIButton!
    @IBOutlet weak var storesLbl: UILabel!
    @IBOutlet weak var storesView: UIView!
    @IBOutlet weak var storesImageView: UIImageView!
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    @IBOutlet weak var dropDownTopView: UIView!{
        didSet{
            CommonFunctions.CornerRadius([], textViews: [], views: [dropDownTopView], btns: [])
        }
    }
    @IBOutlet weak var sortByLbl: UILabel!
    @IBOutlet weak var dropDownLabel: UILabel!
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBOutlet weak var dropDownImgView: UIImageView!
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tabBar: UITabBarItem!
    @IBOutlet weak var headerBookingsView: UIView!
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        pageNumber = 1
//        self.bookingsAPI()
        //Deliveries Btn Selected
        if buttonSelected == 0 {
            self.tblView.es.addPullToRefresh { [self] in
                //Pagination
                pageNumber = 1
                sorting = 4
                //Pagination
                canPagination = true
                IsApiHitting = false
                IsApiHitOnce = false
                data = []
                
                bookingsAPI()
            }
        }else {
            //            self.tblView.es.addPullToRefresh { [self] in
            //
            //            }
        }
        
        dropDownBtn.addTarget(self, action: #selector(dropDownBtnAction(_:)), for: .touchUpInside)
        deliveriesBtn.addTarget(self, action: #selector(deliveriesBtnAction(_:)), for: .touchUpInside)
        storesBtn.addTarget(self, action: #selector(storesBtnAction(_:)), for: .touchUpInside)
        CommonFunctions.viewShadow(headerBookingsView)
        segmentController.layer.cornerRadius = 0.0
        segmentController.backgroundColor = UIColor.bGColor
        segmentController.layer.borderWidth = 1.2
        
        segmentController.layer.borderColor = UIColor.ButtonGradientLightColor.cgColor
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.ButtonGradientLightColor], for: .normal)
        segmentController.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        //        self.segmentController.layer.masksToBounds = true
        self.segmentController.tintColor = UIColor.red
    }
    override func viewWillAppear(_ animated: Bool) {
        //Deliveries Btn Selected
        if buttonSelected == 0 {
            pageNumber = 1
            self.bookingsAPI()
        }//Stores Btn Selected
        else {
            
        }
    }
    //MARK:- Segement Controller Action
    @IBAction func segmentController(_ sender: UISegmentedControl) {
        //Deliveries bTn selected
        if buttonSelected == 0 {
            //upcoming
            if sender.selectedSegmentIndex == 0 {
                dropDownTopView.isHidden = false
                segmentedControllerSelected = 1
                self.status = 2
                self.pageNumber = 1
                data = []
                bookingsAPI()
                tblView.reloadData()
            }
            //delivered
            if sender.selectedSegmentIndex == 1 {
                dropDownTopView.isHidden = true
                segmentedControllerSelected = 2
                self.status = 4
                self.pageNumber = 1
                data = []
                bookingsAPI()
                tblView.reloadData()
            }
            //cancelled
            if sender.selectedSegmentIndex == 2 {
                dropDownTopView.isHidden = true
                segmentedControllerSelected = 3
                self.status = 6
                self.pageNumber = 1
                sorting = 4
                data = []
                bookingsAPI()
                tblView.reloadData()
            }
        }
        //Stores bTn selected
        else {
            //upcoming
            if sender.selectedSegmentIndex == 0 {

            }
            //delivered
            else if sender.selectedSegmentIndex == 1 {

            }
            //cancelled
            else {

            }
        }
//        //upcoming
//        if sender.selectedSegmentIndex == 0 {
//            dropDownTopView.isHidden = false
//            tblView.isHidden = false
//            segmentedControllerSelected = 1
//            self.status = 2
//            //Deliveries bTn selected
//            if buttonSelected == 0 {
//                bookingsAPI()
//                tblView.reloadData()
//            }
//            //Stores bTn selected
//            else {
//
//            }
//        }
//        //delivered
//        if sender.selectedSegmentIndex == 1 {
//            dropDownTopView.isHidden = true
//            tblView.isHidden = false
//            segmentedControllerSelected = 2
//            self.status = 4
//            //Deliveries bTn selected
//            if buttonSelected == 0 {
//                bookingsAPI()
//                tblView.reloadData()
//            }
//            //Stores bTn selected
//            else {
//
//            }
//        }
//        //cancelled
//        if sender.selectedSegmentIndex == 2 {
//            dropDownTopView.isHidden = true
//            segmentedControllerSelected = 3
//            self.status = 6
//            //Deliveries bTn selected
//            if buttonSelected == 0 {
//                bookingsAPI()
//                tblView.reloadData()
//            }
//            //Stores bTn selected
//            else {
//
//            }
//        }
    }
    
    
    //MARK:- Button Actions
    @objc func deliveriesBtnAction(_ sender: UIButton){
        deliveriesView.backgroundColor = UIColor.ButtonGradientLightColor
        deliveriesLbl.textColor = .white
        deliveriesImageView.image = Asset.deliveries_w.image()
        storesView.backgroundColor = UIColor.viewBackgroundColor
        storesLbl.textColor = .black
        storesImageView.image = Asset.stores_b.image()
        buttonSelected = 0
        dropDownTopView.isHidden = false
        tblView.reloadData()
    }
    @objc func storesBtnAction(_ sender: UIButton){
        storesView.backgroundColor = UIColor.ButtonGradientLightColor
        storesLbl.textColor = .white
        storesImageView.image = Asset.stores_w.image()
        deliveriesView.backgroundColor = UIColor.viewBackgroundColor
        deliveriesLbl.textColor = .black
        deliveriesImageView.image = Asset.deliveries_b.image()
        buttonSelected = 1
        dropDownTopView.isHidden = false
        tblView.reloadData()
    }
    //MARK:- Drop Down Btn Action
    @objc func dropDownBtnAction(_ sender: UIButton){
        CommonFunctions.dropDown(dropDownImgView, dropDown: dropDown, sender: sender, dataSource: ["Recently Accepted","Earliest Pickup"])
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            //sender.setTitle(item, for: .normal)
            self!.dropDownLabel.text = "\(item)"
            self!.dropDownImgView.image = Asset.drop_down.image()
            if index == 0 {
                //Deliveries bTn selected
                if self?.buttonSelected == 0 {
                    self?.sorting = 4
                    self?.bookingsAPI()
                }
                //Stores bTn selected
                else {
                    
                }
            }
            else {
                //Deliveries bTn selected
                if self?.buttonSelected == 0 {
                    self?.sorting = 5
                    self?.bookingsAPI()
                }
                //Stores bTn selected
                else {
                    
                }
            }
        }
    }
    
}
//MARK:- Table View Methods
extension bookingsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if buttonSelected == 0{
            return data.count
        }
        else {
            return 4 
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //deliveries Btn is selected
        if buttonSelected == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "bookingsDeliveriesCell") as! bookingsDeliveriesCell
            cell.setData(data[indexPath.row], buttonSelected: buttonSelected, segmentControllerSelected: segmentedControllerSelected)
            return cell
        }
        //stores Btn is selected
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "bookingsStoresCell") as! bookingsStoresCell
            //stores upcoming
            if segmentedControllerSelected == 1 {
                cell.deliveredLbl.isHidden = false
            }
            //stores delivered
            else if segmentedControllerSelected == 2{
                cell.deliveredLbl.isHidden = true
            }
            //stores cancelled
            else {
                cell.deliveredLbl.isHidden = false
                
            }
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // deliveries Btn Selecetd
        if buttonSelected == 0 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "bookingsDetailVC") as! bookingsDetailVC
            vc.order_id = data[indexPath.row].id
            vc.job_type = data[indexPath.row].jobType
            vc.deliver_type_id = data[indexPath.row].deliverTypeID
            // self.navigationController?.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        // stores Btn Selecetd
        else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "jobsDetailVC") as? jobsDetailVC
            vc?.buttonSelected = self.buttonSelected
            vc?.headerLbl?.text = "Booking Details"
            //            vc.order_id = data[indexPath.row].id
            //            vc.job_type = data[indexPath.row].jobType
            //            vc.deliver_type_id = data[indexPath.row].deliverTypeID
            // self.navigationController?.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    //    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 380
    //    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let lastSectionIndex = tableView.numberOfSections - 1
//        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
//        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            // print("this is the last cell")
//        }
        
        if (indexPath.row == (data.count-2)){
            if canPagination && !IsApiHitting && IsApiHitOnce{
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                self.tblView.tableFooterView = spinner
                self.tblView.tableFooterView?.isHidden = false
//                pageNumber += 1
                self.bookingsAPI()
            }
        }
    }

}
//MARK:- BookingsAPI Methods
extension bookingsVC{
    func bookingsAPI(){
        //CommonFunctions.showLoader()
        let params:[String:Any]
        if self.segmentedControllerSelected == 1 {
             params = [
                "status": self.status as Any,
                "sorting": self.sorting as Any ,
                "page": self.pageNumber as Any,
                "limit": self.limit as Any
            ]
        }
        else {
             params = [
                "status": self.status as Any,
                "page": self.pageNumber as Any,
                "limit": self.limit as Any
            ]
        }
        
        if IsApiHitting{
            return
        }
        IsApiHitting = true
        if canPagination {
            pageNumber = pageNumber + 1
        }
        ApiHandler.callApiWithParameters(url:  appConstantURL().getDriverDeliveriesURL, withParameters: params, ofType: DriverDeliveriesAPI.self, success2: { (response) in
            //to stop paginating when count of data is less 10
            if response.count! == 10 {
                self.canPagination = true
            }
            else {
                self.canPagination = false
            }
            
//            if response.count! == 5 {
//                self.canPagination = true
//            }else{
//                self.canPagination = false
//            }
            self.IsApiHitOnce = true
            self.IsApiHitting = false
            
            if self.pageNumber == 1 {
                self.data = response.deliveries
            }
            else{
                self.data.append(contentsOf:  response.deliveries)
            }
            //CommonFunctions.hideLoader()
            self.tblView.es.stopPullToRefresh()
            self.spinner.endEditing(true)
            self.tblView.tableFooterView?.isHidden = true
            self.tblView.reloadData()
        }, failure: { (reload, error) in
            print(error)
            self.IsApiHitting = false
            //CommonFunctions.hideLoader()
            self.tblView.es.stopPullToRefresh()
            self.spinner.endEditing(true)
            self.tblView.tableFooterView?.isHidden = true
            CommonFunctions.toster(error)
        }, method: .GET, img: nil, imageParamater: "", headerPresent: true)
    }
}
