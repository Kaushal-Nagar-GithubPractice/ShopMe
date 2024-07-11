//
//  UserReviewsTableViewCell.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 05/07/24.
//

import UIKit

class UserReviewsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblUserReview: UILabel!
    @IBOutlet weak var btnRatings: UIButton!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    
    var Rating : Double = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
