//
//  OrderedItemTableViewCell.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 24/06/24.
//

import UIKit

class OrderedItemTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductQuantity: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var viewOrderItem: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewOrderItem.layer.cornerRadius = 8
        viewOrderItem.layer.masksToBounds = true
        
        imgProduct.layer.cornerRadius = 10
        imgProduct.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
