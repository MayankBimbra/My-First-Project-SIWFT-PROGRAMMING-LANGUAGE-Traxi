//
//  itemForPickupjobDetailsCell.swift
//  Traxi
//
//  Created by IOS on 07/04/21.
//

import UIKit

class itemForPickupjobDetailsCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var moneyLblbelowNameLbl: UILabel!
    @IBOutlet weak var moneyLblAboveQuantityLbl: UILabel!
    
    @IBOutlet weak var quantityLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setData(_ data: GetOrderDetailsAPI?){
    
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
