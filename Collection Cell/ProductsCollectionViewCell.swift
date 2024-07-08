//
//  ProductsCollectionViewCell.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 24/06/24.
//

import UIKit
import Cosmos
import SVProgressHUD
protocol AddtoWishlist{
    func onClickAddtoWishlist(isLogin : Bool)
}


class ProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblPrice: UILabel!

    @IBOutlet weak var starView: CosmosView?
    @IBOutlet weak var lblStrikePrice: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var viewProduct: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "$199.00")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        
        lblStrikePrice.attributedText = attributeString
        viewProduct.layer.cornerRadius = 15
        viewProduct.layer.masksToBounds = true
        viewProduct.backgroundColor = UIColor.systemGray5
        starView?.settings.fillMode = .precise
    }
    
    
  
        

}
