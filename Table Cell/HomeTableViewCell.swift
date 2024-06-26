//
//  HomeTableViewCell.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 24/06/24.
//

import UIKit

protocol ProductSelect {
    func selectedProduct(imageName: String,ProductName : String, Price : Double)
}


class HomeTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
   
    @IBOutlet weak var HeightConstraint: NSLayoutConstraint!
    var arrProductImages = ["product-1","product-2","product-3","product-4","product-5","product-6","product-7","product-8","product-9","product-1","product-2","product-3","product-4","product-5","product-6","product-7","product-8","product-9"]
    var arrProductName = ["Camera","Tshirt","Lamp","Shoes","Drone","Watch","Top","Creams","Chair","Camera","Tshirt","Lamp","Shoes","Drone","Watch","Top","Creams","Chair"]
    var arrProductPrice = [599.00,59.00,123.00,89.00,1099.95,259.00,75.00,29.00,659.99,599.00,59.00,123.00,89.00,1099.95,259.00,75.00,29.00,659.99]
    var delegate : ProductSelect?

    @IBOutlet weak var collectionProducts: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionProducts.delegate = self
        collectionProducts.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

 
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrProductImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCollectionViewCell", for: indexPath) as! ProductsCollectionViewCell
        cell.imgProduct.image = UIImage(named: arrProductImages[indexPath.row])
        cell.lblProductName.text = arrProductName[indexPath.row]
        cell.lblPrice.text = "$\(arrProductPrice[indexPath.row])"
        cell.lblStrikePrice.text =  "$\(arrProductPrice[indexPath.row])"
        print(cell.frame.height)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 5, height: 285)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.selectedProduct(imageName: arrProductImages[indexPath.row],ProductName: arrProductName[indexPath.row],Price: arrProductPrice[indexPath.row])
        
    }
    

}
