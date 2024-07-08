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
    var delegate : ReloadCollectionView?
    
    var WishlistProducts : [wishlist_Products] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "$199.00")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        
        lblStrikePrice.attributedText = attributeString
        viewProduct.layer.cornerRadius = 15
        viewProduct.layer.masksToBounds = true
        viewProduct.backgroundColor = UIColor.systemGray5
        
    }
    @IBAction func onClickWishList(_ sender: Any) {
        print("Delete product from wishlist")
        
        let URL = Constant.Delete_Product_From_Wishlist_URL + (WishlistProducts[(sender as AnyObject).tag].productId ?? "")
        
        let request  = APIRequest(isLoader: true, method: .delete, path: URL, headers: HeaderValue.headerWithToken.value, body: nil)
        
        CallAPIToDeleteProductFromWishlist(request: request)
        
    }
    
    func CallAPIToDeleteProductFromWishlist(request: APIRequest){ APIClient().perform(request)
        { (data,Error) in
        if let data = data {
            self.delegate?.ReloadCollectionView()
        } else {
            
        }
    }
    }
    
}

protocol ReloadCollectionView{
    func ReloadCollectionView()
}
