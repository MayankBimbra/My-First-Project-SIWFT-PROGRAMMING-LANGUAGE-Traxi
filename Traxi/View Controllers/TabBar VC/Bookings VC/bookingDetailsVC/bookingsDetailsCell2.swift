//
//  bookingsDetailsCell2.swift
//  Traxi
//
//  Created by IOS on 08/04/21.
//

import UIKit

class bookingsDetailsCell2: UITableViewCell {

    @IBOutlet weak var distanceLocationLbl: UILabel!
    @IBOutlet weak var pickupPointLbl: UILabel!
    @IBOutlet weak var pickupPointView: UIView!
    @IBOutlet weak var pickupPointImageView: UIImageView!
    @IBOutlet weak var dottedView: UIView!{
        didSet{
            dottedView.createDottedLine(width: 2.0, color: UIColor.black.cgColor)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
