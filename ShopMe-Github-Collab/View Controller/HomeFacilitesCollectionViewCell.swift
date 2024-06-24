//
//  HomeFacilitesCollectionViewCell.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 24/06/24.
//

import UIKit

class HomeFacilitesCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var lblFacilites: UILabel!
    @IBOutlet weak var imageFacilites: UIImageView!
    @IBOutlet weak var viewFacilites: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewFacilites.backgroundColor = UIColor.systemGray5
        viewFacilites.layer.cornerRadius = 15
        viewFacilites.layer.masksToBounds = true
    }
}
