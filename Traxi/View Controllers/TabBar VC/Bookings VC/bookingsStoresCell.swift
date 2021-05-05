//
//  bookingsStoresCell.swift
//  Traxi
//
//  Created by IOS on 07/04/21.
//

import UIKit

class bookingsStoresCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!{
        didSet {
            CommonFunctions.CornerRadius([], textViews: [], views: [cellView], btns: [])
        }
    }
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var shopNameLbl: UILabel!
    @IBOutlet weak var ratingsLbl: UILabel!
    @IBOutlet weak var ratingsImage: UIImageView!
    @IBOutlet weak var deliveredLbl: UILabel!
    @IBOutlet weak var pickupDateLbl: UILabel!
    @IBOutlet weak var pickupDateDescriptionLbl: UILabel!
    @IBOutlet weak var pickupTimeDescriptionLbl: UILabel!
    @IBOutlet weak var pickupTimeLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var moneyLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
