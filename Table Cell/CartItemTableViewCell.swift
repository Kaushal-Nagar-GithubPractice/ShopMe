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
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblColor: UILabel!
    var increaseQuantity: (() -> Void)?
    var decreaseQuantity: (() -> Void)?
    
    // MARK: - View Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
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
        viewQuantityManage.layer.cornerRadius = 5
        viewQuantityManage.borderColor = UIColor.gray
        viewQuantityManage.borderWidth = 0.2
        viewQuantityManage.clipsToBounds = true
        
        viewCell.backgroundColor = UIColor.systemGray6
        applyShadow(view: viewCell)

        btnRemoveItem.setImage(UIImage(named: "cancel"), for: .normal)
    }
}

protocol removeFromCart {
    func removeItemFromCart(sender: Int)
}
