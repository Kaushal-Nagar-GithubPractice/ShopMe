//
//  FaqQuestionTableCell.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 10/07/24.
//

import UIKit

class FaqQuestionTableCell: UITableViewCell {
    
    
    @IBOutlet weak var lblAnswerLable: UILabel!
    @IBOutlet weak var lblQuestionLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
