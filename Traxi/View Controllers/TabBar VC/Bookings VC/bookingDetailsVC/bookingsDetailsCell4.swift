//
//  bookingsDetailsCell4.swift
//  Traxi
//
//  Created by IOS on 08/04/21.
//

import UIKit

class bookingsDetailsCell4: UITableViewCell {

    @IBOutlet weak var dropoffPointLbl: UILabel!
    @IBOutlet weak var dottedView: UIView!{
        didSet{
            dottedView.createDottedLine(width: 2.0, color: UIColor.black.cgColor)
        }
    }
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var circleImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        circleView.layer.cornerRadius = circleView.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
