//
//  HomeHeaderCollectionViewCell.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 24/06/24.
//

import UIKit

class HomeHeaderCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var lblDetailHeader: UILabel!
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var imageHeader: UIImageView!
    @IBOutlet weak var viewHeader: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        ApplyShadow(view: viewHeader)
        imageHeader.layer.cornerRadius = 15
        imageHeader.layer.masksToBounds = true
    }
}
