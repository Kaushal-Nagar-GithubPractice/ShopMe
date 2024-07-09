//
//  OrderDetailTabelCell.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 04/07/24.
//

import UIKit

class OrderDetailTabelCell: UITableViewCell {

    @IBOutlet weak var CellMainView: UIView!
    @IBOutlet weak var ImgProductImage: UIImageView!
    @IBOutlet weak var lblProductNameLAbel: UILabel!
    @IBOutlet weak var lblQauntityLabel: UILabel!
    @IBOutlet weak var lblProductPriceLabel: UILabel!
    @IBOutlet weak var lblTotalPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SetUI()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func SetUI(){
        ImgProductImage.layer.cornerRadius = 10
        ImgProductImage.layer.borderWidth = 1
        CellMainView.layer.cornerRadius = 10
    }

}
