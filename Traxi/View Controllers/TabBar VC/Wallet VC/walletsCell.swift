//
//  walletsCell.swift
//  Traxi
//
//  Created by IOS on 01/04/21.
//

import UIKit

class walletsCell: UITableViewCell {
    //MARK:- UI Components
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var moneyLbl: UILabel!
    @IBOutlet weak var deliveryLbl: UILabel!
    @IBOutlet weak var receivedFromLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //MARK:- Set Data Method
    func setData(_ data: GetDriverTransactionsAPI?, index: Int){
        moneyLbl.text = "$" + String(data?[index].amount ?? 0)
        deliveryLbl.text = data?[index].status ?? ""
        receivedFromLbl.text = "Received from " + (data?[index].name ?? "")
        
        if data?[index].createdAt ?? "" != "" {
            //To extract date and Time
            let fullDateAndTime = "\(data![index].createdAt!)"
            let (DATE,TIME) =  self.dateAndTime(fullDateAndTime)
            dateLbl.text = "\(DATE)" + " \(TIME)"
        }
    }
    //MARK:- To Extract Date and Time
    func dateAndTime(_ fullDateAndTime:String) -> (String, String) {
        var Time = ""
        var date = ""
        let dateAsString = fullDateAndTime
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let TimeDate = (dateFormatter.date(from: dateAsString))
        dateFormatter.dateFormat =  "h:mm a"
        Time = dateFormatter.string(from: TimeDate!)
    //        print("12 hour formatted Time:",Time)
        
        dateFormatter.dateFormat = "d-MMM-yyyy"
        date = dateFormatter.string(from: TimeDate!)
    //        print("12 hour formatted Date:",date)
        return (date,Time)
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
