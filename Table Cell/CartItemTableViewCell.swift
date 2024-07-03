//
//  CartItemTableViewCell.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 24/06/24.
//

import UIKit
import Kingfisher

class CartItemTableViewCell: UITableViewCell {
    
    // MARK: - Variables & Outlets
    var removeItemDelegate:removeFromCart?
    var itemQuantity: Int = 1
    var itemPrice:Int = 0
    var imageUrl:String = ""
    
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblItemPrice: UILabel!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var viewQuantityManage: UIView!
    @IBOutlet weak var btnDecrease: UIButton!
    @IBOutlet weak var btnIncrease: UIButton!
    @IBOutlet weak var btnRemoveItem: UIButton!
    @IBOutlet weak var lblTotalItemPrice: UILabel!
    var increaseQuantity: (() -> Void)?
    var decreaseQuantity: (() -> Void)?
    
    // MARK: - View Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewQuantityManage.layer.cornerRadius = 8
        viewQuantityManage.clipsToBounds = true
        setUI()
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
    @IBAction func onClickDecreaseQuantity(_ sender: UIButton) {
        decreaseQuantity?()

    }
    
    @IBAction func onClickIncreaseQuantity(_ sender: UIButton) {
        increaseQuantity?()

    }
    
    func updatelblItemPrice(price:Int){
        lblTotalItemPrice.text = String(describing: price)
        print(lblItemPrice.text)
    }
    
    @IBAction func onClickRemoveItemFromCart(_ sender: UIButton) {
        removeItemDelegate?.removeItemFromCart(sender: sender.tag )
    }
    
    
    func setUI(){
        btnIncrease.layer.cornerRadius = 8
        btnIncrease.clipsToBounds = true
        btnDecrease.layer.cornerRadius = 8
        btnDecrease.clipsToBounds = true
        
        viewCell.backgroundColor = UIColor.systemGray6
        viewCell.layer.cornerRadius = 10
        viewCell.layer.masksToBounds = true
        
        btnRemoveItem.setImage(UIImage(named: "cancel"), for: .normal)
    }
}

protocol removeFromCart {
    func removeItemFromCart(sender: Int)
}
