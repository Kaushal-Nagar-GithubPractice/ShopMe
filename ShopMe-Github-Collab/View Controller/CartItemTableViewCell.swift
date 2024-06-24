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
    
    // MARK: - View Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        viewCell.layer.cornerRadius = 10
//        viewCell.clipsToBounds = true
//
        viewQuantityManage.layer.cornerRadius = 10
        viewQuantityManage.clipsToBounds = true
    
        lblQuantity.text = String(itemQuantity)
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
        if itemQuantity > 1{
            itemQuantity -= 1
            lblQuantity.text = String(itemQuantity)
            lblItemPrice.text = String(itemQuantity * itemPrice)
        }
    }
    
    @IBAction func onClickIncreaseQuantity(_ sender: Any) {
        itemQuantity += 1
        lblQuantity.text = String(itemQuantity)
        lblItemPrice.text = String(itemQuantity * itemPrice)
        print("ppppp-======",itemQuantity * (Int(lblItemPrice.text!) ?? 1))
        print("qunatity===",itemQuantity)
    }
    
    
    @IBAction func onClickRemoveItemFromCart(_ sender: Any) {
        removeItemDelegate?.removeItemFromCart(sender: sender as! UIButton)
    }
}

protocol removeFromCart {
    func removeItemFromCart(sender:UIButton)
}
