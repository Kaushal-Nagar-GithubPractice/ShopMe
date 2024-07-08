//
//  wishListCVCell.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 05/07/24.
//

import UIKit

class wishListCVCell: UICollectionViewCell {
    var IsWishList = false
    @IBOutlet weak var viewProduct: UIView!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblStrikePrice: UILabel!
    @IBOutlet weak var btnWishList: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        SetWishlistbutton()
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "$199.00")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        
        lblStrikePrice.attributedText = attributeString
        viewProduct.layer.cornerRadius = 15
        viewProduct.layer.masksToBounds = true
        viewProduct.backgroundColor = UIColor.systemGray5
        
        print(btnWishList.tag)

    }
    @IBAction func onClickWishList(_ sender: Any) {
        
        
    }
    
    func SetWishlistbutton(){
        if IsWishList{
            btnWishList.tintColor = .systemRed
        }else{
            btnWishList.tintColor = UIColor(named: "Custom Black")
        }
    }
}
