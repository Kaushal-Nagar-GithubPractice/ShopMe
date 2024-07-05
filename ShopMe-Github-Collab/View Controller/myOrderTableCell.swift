//
//  myOrderTableCell.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 24/06/24.
//

import UIKit

class myOrderTableCell: UITableViewCell {
    
    
    var StatusViewBorderColor = UIColor.systemGreen
    @IBOutlet weak var VwStatusView: UIView!
    
    @IBOutlet weak var btnStatusbutton: UIButton!
    @IBOutlet weak var VwMyOrderTablebgView: UIView!

    @IBOutlet weak var lblOrderID: UILabel!
    @IBOutlet weak var lblOrderDate: UILabel!
    @IBOutlet weak var lblTotalItem: UILabel!
    @IBOutlet weak var lblTotalPrize: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    
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
        VwMyOrderTablebgView.layer.cornerRadius = 10
        VwStatusView.layer.cornerRadius = 10
    }

}
