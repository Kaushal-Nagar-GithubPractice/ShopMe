//
//  CategoriesCollectionViewCell.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 24/06/24.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var lblCategoryQuantity: UILabel!
    @IBOutlet weak var lblCategoryName: UILabel!
    
    @IBOutlet weak var imageCategories: UIImageView!
    @IBOutlet weak var viewCategories: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewCategories.backgroundColor = UIColor.systemGray5
        viewCategories.layer.cornerRadius = 15
        viewCategories.layer.masksToBounds = true
        
        imageCategories.layer.cornerRadius = 15
        imageCategories.layer.masksToBounds = true
    }
}
