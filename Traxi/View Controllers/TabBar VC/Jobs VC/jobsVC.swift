//
//  jobsVC.swift
//  Traxi
//
//  Created by IOS on 26/03/21.
//

import UIKit
import DropDown
import ESPullToRefresh

class jobsVC: UIViewController {
    //MARK:- Variables
    let spinner = UIActivityIndicatorView(style: .gray)
    let dropDown = DropDown()
    var data:  [Delivery] = []
    var refreshContrl = UIRefreshControl()
    var status: Int = 1
    var sorting: Int = 1
    var pageNumber: Int = 1
    var limit: Int = 10
    
    //Pagination
    var canPagination: Bool = true
    var IsApiHitting: Bool = false
    var IsApiHitOnce: Bool = false
    
    //MARK:- UI Components
    @IBOutlet weak var topSmallView: UIView!
    @IBOutlet weak var sortbyLbl: UILabel!
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBOutlet weak var dropDownLabel: UILabel!
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var dropDownImageView: UIImageView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var headerJobsView: UIView!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        //  addrefreshControl()
        pageNumber = 1
        self.callJobsAPI()
    }
    override func viewWillAppear(_ animated: Bool) {

       //self.tblView.reloadData()
    }
}

//MARK:- Other Functions
extension jobsVC {
    func setupUI(){
        dropDownBtn.addTarget(self, action: #selector(dropDownBtnAction(_:)), for: .touchUpInside)
        CommonFunctions.viewShadow(headerJobsView)
        CommonFunctions.CornerRadius([], textViews: [], views: [topSmallView], btns: [])
        
        self.tblView.es.addPullToRefresh { [self] in
            pageNumber = 1
            //Pagination
            canPagination = true
            IsApiHitting = false
            IsApiHitOnce = false
            data = []
            
            callJobsAPI()
        }
    }
    //    // Simple Refresh Control in TblView
    //    func addrefreshControl() {
    //        refreshContrl.tintColor = UIColor.ButtonGradientLightColor
    //        refreshContrl.addTarget(self, action: #selector(refreshTblView), for: .valueChanged)
    //        tblView.addSubview(refreshContrl)
    //    }
    //    @objc func refreshTblView() {
    //        callJobsAPI()
    //       // refreshContrl.endRefreshing()
    //        tblView.reloadData()
    //    }
    
    //MARK:- Button Actions
    @objc func dropDownBtnAction(_ sender: UIButton){
        CommonFunctions.dropDown(dropDownImageView, dropDown: dropDown, sender: sender, dataSource: ["Recent Posted","Time","Payment","Distance"])
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            //sender.setTitle(item, for: .normal)
            self!.dropDownLabel.text = "\(item)"
            self!.dropDownImageView.image = Asset.drop_down.image()
            if index == 0 {
                self?.sorting = 1
                //                if self?.sorting != 1 {
                self?.callJobsAPI()
                //                }
            }
            else if index == 1 {
                self?.sorting = 2
                self?.callJobsAPI()
            }
            else if index == 2{
                self?.sorting = 3
                self?.callJobsAPI()
            }
            else {
                self?.sorting = 4
                self?.callJobsAPI()
            }
        }
    }
    @objc func acceptBtnAction(_ sender: UIButton){
        CommonFunctions.showLoader()
        let params: [String: Any] = [
            "delivery_id": data[sender.tag].id ?? 0,
            "job_type": data[sender.tag].jobType ?? 0,
            "pickup_time": data[sender.tag].pickupTime  ?? "",
            "estimated_time": data[sender.tag].estimatedDeliveryTime ?? ""
        ]
        ApiHandler.callApiWithParameters(url: appConstantURL().deliveryAcceptedURL, withParameters: params, ofType: DeliveryAcceptedAPI.self, success2: { (response) in
            CommonFunctions.hideLoader()
            CommonFunctions.toster(response.message ?? "")
            self.callJobsAPI()
        }, failure: { (false, error) in
            print(error)
            CommonFunctions.hideLoader()
        }, method:.PUTWithJSON, img: nil, imageParamater: "", headerPresent: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0, execute: {
            self.tblView.reloadData()
        })
    }
}


//MARK:- API Methods
extension jobsVC {
    func callJobsAPI(){
        //CommonFunctions.showLoader()
        let params:[String:Any] = [
            "status": self.status as Any,
            "sorting": self.sorting as Any ,
            "page": self.pageNumber as Any,
            "limit": self.limit as Any
        ]
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
           // CommonFunctions.hideLoader()
            //   self.refreshContrl.endRefreshing()
            self.tblView.es.stopPullToRefresh()
            self.spinner.endEditing(true)
            self.tblView.tableFooterView?.isHidden = true
            DispatchQueue.main.async {
                  self.tblView.reloadData()
            }

        }, failure: { (reload, error) in
            print(error)
            self.IsApiHitting = false
            //   CommonFunctions.hideLoader()
            //   self.refreshContrl.endRefreshing()
            self.tblView.es.stopPullToRefresh()
            self.spinner.endEditing(true)
            self.tblView.tableFooterView?.isHidden = true
            CommonFunctions.toster(error)
        }, method: .GET, img: nil, imageParamater: "", headerPresent: true)
    }
}
//MARK:- TableView Methods
extension jobsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobsCell") as! jobsCell
        cell.setData(data[indexPath.row])
        cell.acceptBtn.tag = indexPath.row
        cell.acceptBtn.addTarget(self, action: #selector(acceptBtnAction(_:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = UIStoryboard(name: "TabBar", bundle: Bundle.main)
        let controller = story.instantiateViewController(withIdentifier: "jobsDetailVC") as! jobsDetailVC
        controller.order_id = data[indexPath.row].id
        controller.job_type = data[indexPath.row].jobType
        controller.pickup_time = data[indexPath.row].pickupTime  ?? ""
        controller.estimated_time = data[indexPath.row].estimatedDeliveryTime ?? ""
        self.navigationController?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
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
                self.callJobsAPI()
            }
        }
    }
}
