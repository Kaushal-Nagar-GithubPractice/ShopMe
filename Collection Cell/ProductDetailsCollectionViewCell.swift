//
//  ProductDetailsCollectionViewCell.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 01/07/24.
//

import UIKit

class ProductDetailsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewChoice: UIView!
    
    @IBOutlet weak var lblChoice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewChoice.layer.cornerRadius = 12
        viewChoice.layer.borderWidth = 2
        viewChoice.layer.borderColor = UIColor.black.cgColor
    }
}
