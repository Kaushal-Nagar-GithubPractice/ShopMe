//
//  ProductsCollectionViewCell.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 24/06/24.
//

import UIKit
import Cosmos

protocol AddtoWishlist{
    func onClickAddtoWishlist()
}


class ProductsCollectionViewCell: UICollectionViewCell {
    
//    static let ProdColCell = ProductsCollectionViewCell()
    var arrProducts = [Products]()
    @IBOutlet weak var lblPrice: UILabel!
    var IsWishList = false
    var delegate : AddtoWishlist?
    @IBOutlet weak var btnWishlist: UIButton!
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
        SetWishlistbutton()
    }
    
    func SetWishlistbutton(){
        if IsWishList{
            btnWishlist.tintColor = .systemRed
        }else{
            btnWishlist.tintColor = .black
        }
    }
    
    @IBAction func OnClickWishList(_ sender: UIButton) {
//        IsWishList.toggle()
//        SetWishlistbutton()
//
        callApiWishList(productId: arrProducts[sender.tag]._id ?? "")
        
    }
        
    func callApiWishList(productId : String){
        let request = APIRequest(isLoader: true, method: HTTPMethods.post, path: Constant.ADD_TO_WHISLIST+productId, headers: HeaderValue.headerWithToken.value, body: nil)
        Post_WishlistViewModel.ApiAddWishlist.getPostRatingData(request: request) { response in
            DispatchQueue.main.async {
                print(response)
                self.delegate?.onClickAddtoWishlist()
            }
            
        } error: { error in
            print(error)
        }

    }
}
