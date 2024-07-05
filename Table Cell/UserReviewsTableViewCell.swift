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
    override func awakeFromNib() {
        super.awakeFromNib()
        colorOnRating()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func colorOnRating(){
        if (btnRatings.titleLabel?.text as! NSString).integerValue <= Int(2.5) {
            btnRatings.tintColor = .red
        }
        else{
            btnRatings.tintColor = .systemYellow
        }
      
    }

}
