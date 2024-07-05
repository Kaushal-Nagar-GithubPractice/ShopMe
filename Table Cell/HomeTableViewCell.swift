//
//  HomeTableViewCell.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 24/06/24.
//

import UIKit

protocol ProductSelect {
    func selectedProduct(productId : String)
}


class HomeTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, AddtoWishlist {
    
    
    
   var arrProducts = [Products]()
    @IBOutlet weak var HeightConstraint: NSLayoutConstraint!
    var delegate : ProductSelect?

    @IBOutlet weak var collectionProducts: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionProducts.delegate = self
        collectionProducts.dataSource = self
        collectionProducts.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCollectionViewCell", for: indexPath) as! ProductsCollectionViewCell
        if !arrProducts.isEmpty {
//            print(arrProducts)
            cell.arrProducts = arrProducts
            cell.imgProduct.setImageWithURL(url: arrProducts[indexPath.row].images?.first ?? "", imageView: cell.imgProduct)
//            cell.starView.text = arrProducts[indexPath.row]
            cell.delegate = self
            cell.lblProductName.text = arrProducts[indexPath.row].productName
            cell.lblPrice.text = "$\(arrProducts[indexPath.row].sellingPrice ?? 1234)"
            cell.lblStrikePrice.text =  "$\(arrProducts[indexPath.row].price ?? 1556)"
            cell.starView?.rating = arrProducts[indexPath.row].ratings ?? 0
            cell.starView?.text = "\(arrProducts[indexPath.row].ratings ?? 0)"
            cell.btnWishlist.tag = indexPath.row
            cell.IsWishList = arrProducts[indexPath.row].isWishList ?? false
        }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 5, height: 285)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.selectedProduct(productId: arrProducts[indexPath.row]._id ?? "")
        
    }
    
//    func callApiWishList(productId : String){
//        let request = APIRequest(isLoader: true, method: HTTPMethods.post, path: Constant.ADD_TO_WHISLIST+productId, headers: HeaderValue.headerWithToken.value, body: nil)
//        Post_WishlistViewModel.ApiAddWishlist.getPostRatingData(request: request) { response in
//            print(response)
//        } error: { error in
//            print(error)
//        }
//
//    }
    func onClickAddtoWishlist() {
        collectionProducts.reloadData()
    }
}
