//
//  bookingsDetailVC.swift
//  Traxi
//
//  Created by IOS on 08/04/21.
//

import UIKit


var orderId: Int?
var deliverTypeId: Int?
class bookingsDetailVC: UIViewController {
    //MARK:- Variables
    var order_id: Int!
    var job_type: Int!
    var data: GetOrderDetailsAPI?
    var deliver_type_id: Int?
    //MARK:- UI Components
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.addTarget(self, action: #selector(backBtnAction(_:)), for: .touchUpInside)
        callJobsAPI()
        orderId = self.deliver_type_id
        deliverTypeId = self.order_id
    }
    //MARK:- Button Actions
    @objc func backBtnAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
//MARK:- CallJobs API
extension bookingsDetailVC {
    func callJobsAPI(){
        let params:[String:Any] = [
            "order_id": self.order_id!,
            "job_type": self.job_type!
        ]
        let link = appConstantURL().getOrderDetailsURL
        CommonFunctions.showLoader()
        
        ApiHandler.callApiWithParameters(url: link, withParameters: params, ofType: GetOrderDetailsAPI.self, success2: { (response) in
            self.data = response
            self.tblView.reloadData()
            CommonFunctions.hideLoader()
            
        }, failure: { (reload, error) in
            CommonFunctions.hideLoader()
            CommonFunctions.toster(error)
        }, method: .GET, img: nil, imageParamater: "", headerPresent: true)
    }
}
//MARK:- Table View Methods Extensions
extension bookingsDetailVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        else if section == 1 {
            return data?.pickupDetails.count ?? 0
        }
        else if section == 2{
            return 1
        }
        else if section == 3{
            return data?.dropoffDetails.count ?? 0
        }
        else {
            return 2
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "bookingsDetailsCell1") as! bookingsDetailsCell1
                cell.setData(data,index: indexPath.row)
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "bookingsDetailsCell2") as! bookingsDetailsCell2
                return cell
            }
        }
        else if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "bookingsDetailsCell3") as! bookingsDetailsCell3
            cell.setData(data,index: indexPath.row)
            cell.circleLbl.text = String(indexPath.row + 1)
                return cell
        }
        else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "bookingsDetailsCell4") as! bookingsDetailsCell4
            //Single Delivery
            if data?.deliverTypeID == 1{
                cell.dottedView.isHidden = true
            }
            else {
                cell.dottedView.isHidden = false
            }
            return cell
        }
        else if indexPath.section == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "bookingsDetailsCell5") as! bookingsDetailsCell5
            cell.setData(data,index: indexPath.row)
            cell.circleLbl.text = String(indexPath.row + 1)
                return cell
        }
        else {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "bookingsDetailsCell6") as! bookingsDetailsCell6
                let count = data?.deliveryPackage.count ?? 0
                var array = [String]()
                for i in 0..<count{
                    //this if else is to remove duplicate/redundant name from array
                    if !array.contains(data?.deliveryPackage[i].name ?? ""){
                        array.append(data?.deliveryPackage[i].name ?? "")
                    }
                }
                let joined = array.joined(separator: " | ")
                cell.packageTypeDescriptionLbl.text = joined
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "bookingsDetailsCell7") as! bookingsDetailsCell7
                cell.setData(data,index: indexPath.row)
                cell.controller = self 
                return cell
            }
        }
    }
    
}
