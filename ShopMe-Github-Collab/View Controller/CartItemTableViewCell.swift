//
//  CartItemTableViewCell.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 24/06/24.
//

import UIKit

class CartItemTableViewCell: UITableViewCell {
    
    // MARK: - Variables & Outlets
    var removeItemDelegate:removeFromCart?
    var itemQuantity: Int = 1
    var itemPrice:Int = 0
    
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblItemPrice: UILabel!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var viewQuantityManage: UIView!
    @IBOutlet weak var btnDecrease: UIButton!
    @IBOutlet weak var btnIncrease: UIButton!
    @IBOutlet weak var btnRemoveItem: UIButton!
    var increaseQuantity: (() -> Void)?
    var decreaseQuantity: (() -> Void)?
    
    // MARK: - View Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewQuantityManage.layer.cornerRadius = 10
        viewQuantityManage.clipsToBounds = true
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    override func layoutSubviews() {
          super.layoutSubviews()
          let bottomSpace: CGFloat = 5.0
          self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: bottomSpace, right: 0))
     }

    // MARK: - IBActions
    @IBAction func onClickDecreaseQuantity(_ sender: Any) {
        decreaseQuantity?()
            
            lblQuantity.text = String(itemQuantity)
            lblItemPrice.text = String(itemQuantity * itemPrice)
    }
    
    @IBAction func onClickIncreaseQuantity(_ sender: Any) {
        increaseQuantity?()
        lblQuantity.text = String(itemQuantity)
        lblItemPrice.text = String(itemQuantity * itemPrice)
        
        
    }
    
    
    @IBAction func onClickRemoveItemFromCart(_ sender: UIButton) {
        removeItemDelegate?.removeItemFromCart(sender: sender )
    }
}

protocol removeFromCart {
    func removeItemFromCart(sender:UIButton)
}
