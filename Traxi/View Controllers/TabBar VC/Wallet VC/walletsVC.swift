//
//  walletsVC.swift
//  Traxi
//
//  Created by IOS on 01/04/21.
//

import UIKit
//MARK:-
class walletsVC: UIViewController {
    var btneye: UIButton!
    var data: GetDriverTransactionsAPI?
    var suceess: Bool = false
    //MARK:- UI Components
    @IBOutlet weak var headerWalletsView: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var aboveView: UIView!
    @IBOutlet weak var withdrawMoneyBtn: UIButton!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var moneyLbl: UILabel!
    @IBOutlet weak var transactionsLbl: UILabel!
    @IBOutlet weak var viewAllBtn: UIButton!
    @IBOutlet weak var availableCreditsLbl: UILabel!
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        CommonFunctions.viewShadow(headerWalletsView)
        CommonFunctions.CornerRadius([], textViews: [], views: [headerWalletsView], btns: [withdrawMoneyBtn])
        aboveView.layer.cornerRadius = 6
        amountTF.layer.borderColor = UIColor(rgb: 0xE8C857).cgColor
        amountTF.layer.borderWidth = 1
        amountTF.layer.cornerRadius = 4
        CommonFunctions.viewShadow(aboveView)
        CommonFunctions.btnShadow(withdrawMoneyBtn)
        CommonFunctions.tfPadding([amountTF], pswTFs: [])
        amountTF.placeholder = "$ Enter Amount"
        amountTF.attributedPlaceholder  = NSAttributedString(string: amountTF.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.textColorPlaceholder])
        amountTF.keyboardType = .decimalPad
        amountTF.delegate = self
        
        viewAllBtn.addTarget(self, action: #selector(viewAllBtnAction(_:)), for: .touchUpInside)
        withdrawMoneyBtn.addTarget(self, action: #selector(withdrawMoneyBtnAction(_:)), for: .touchUpInside)
        moneyLbl.text = "$" + String(coreData.shared.wallet_balance)
        getDriverTransactionsAPI()
   
    }
//    override func viewWillAppear(_ animated: Bool) {
//    }
    
    @objc func viewAllBtnAction(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(identifier: "transactionsVC") as! transactionsVC
        vc.data = self.data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func withdrawMoneyBtnAction(_ sender: UIButton){
        if !(amountTF.text!.isEmpty){
            withdrawMoneyAPI()
        }
        else {
            CommonFunctions.toster("Enter a amount first")
        }
    }
}
//MARK:- Textfield to allow only numbers in amountTF
extension walletsVC: UITextFieldDelegate{
func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    //Prevent "0" characters as the first characters. (i.e.: There should not be values like "003" "01" "000012" etc.)
    if textField.text?.count == 0 && string == "0" {
        
        return false
    }
    
    //Limit the character count to 10.
    if ((textField.text!) + string).count > 5 {
        
        return false
    }
    
    //Have a decimal keypad. Which means user will be able to enter Double values. (Needless to say "." will be limited one)
    if (textField.text?.contains("."))! && string == "." {
        
        return false
    }

    //Only allow numbers. No Copy-Paste text values.
    let allowedCharacterSet = CharacterSet.init(charactersIn: "0123456789")
    let textCharacterSet = CharacterSet.init(charactersIn: textField.text! + string)
    if !allowedCharacterSet.isSuperset(of: textCharacterSet) {
        return false
    }
    return true
}
}
//MARK:- APi Methods
extension walletsVC{
    func withdrawMoneyAPI(){
        let params:[String: Any] = [
            "stripe_account_id": coreData.shared.stripe_account_id,
            "amount": amountTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        ]
        ApiHandler.callApiWithParameters(url: appConstantURL().WithdrawalURL, withParameters: params, ofType: WithdrawalAPI.self, success2: { (response) in
            CommonFunctions.toster(response.message!)
            self.getDriverTransactionsAPI()
            self.suceess = true
            self.amountTF.text = ""
        }, failure: { (false, error) in
            print(error)
        }, method: .POST, img: nil, imageParamater: "", headerPresent: true)
    }
    func getDriverTransactionsAPI(){
        CommonFunctions.showLoader()
        ApiHandler.callApiWithParameters(url: appConstantURL().getDriverTransactionsURL, withParameters: [:], ofType: GetDriverTransactionsAPI.self, success2: { (response) in
            self.data = response
         
            self.tblView.reloadData()
            if self.suceess {
                coreData.shared.wallet_balance = (coreData.shared.wallet_balance) - (self.data![0].amount!)
                self.moneyLbl.text = String(coreData.shared.wallet_balance)
            }
            CommonFunctions.hideLoader()
        }, failure: { (false, error) in
            print(error)
            CommonFunctions.hideLoader()
        }, method: .GET, img: nil, imageParamater: "", headerPresent: true)
    }
}
//MARK:- Extension table View
extension walletsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "walletsCell") as! walletsCell
        CommonFunctions.CornerRadius([], textViews: [], views: [cell.cellView], btns: [])
        cell.setData(data, index: indexPath.row)
        return cell
    }
}
