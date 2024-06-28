//
//  ProductsCollectionViewCell.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 24/06/24.
//

import UIKit
import Cosmos
class ProductsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var lblStrikePrice: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var viewProduct: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "$199.00")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        
        lblStrikePrice.attributedText = attributeString
//        cosmosView = CosmosView(frame: CGRect(x: 0, y: 0, width: cosmosView.frame.width, height: cosmosView.frame.height))
        viewProduct.layer.cornerRadius = 15
        viewProduct.layer.masksToBounds = true
        viewProduct.backgroundColor = UIColor.systemGray5
        
        
    }
}
