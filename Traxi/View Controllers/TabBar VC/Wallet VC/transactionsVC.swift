//
//  transactionsVC.swift
//  Traxi
//
//  Created by IOS on 01/04/21.
//

import UIKit

class transactionsVC: UIViewController {
    //MARK:- UI Componets
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var headerTransactionsView: UIView!
    
    //MARK:-  Variables
    var data: GetDriverTransactionsAPI?
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        CommonFunctions.viewShadow(headerTransactionsView)
        backBtn.addTarget(self, action: #selector(backBtnAction(_:)), for: .touchUpInside)
    }
    @objc func backBtnAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
   
}

//MARK:- Extension table View
extension transactionsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionsCell") as! transactionsCell
        cell.setData(data, index: indexPath.row)
        return cell
    }
}
