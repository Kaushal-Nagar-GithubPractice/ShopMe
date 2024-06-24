//
//  ShoppingCartViewController.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 24/06/24.
//

import UIKit

class ShoppingCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, removeFromCart{
    
    // MARK: - Variables and Outlets
    
    var cartItemArray = [["img":"item-1","Name":"Canon camera","Price":"180000"],
                         ["img":"item-2","Name":"T-shirt","Price":"1299"],
                         ["img":"item-3","Name":"Lamp","Price":"7700"],
                         ["img":"item-4","Name":"Shoes","Price":"2000"],
                         ["img":"item-5","Name":"Drone","Price":"12000"],
                         ["img":"item-3","Name":"Lamp","Price":"7700"],
                         ["img":"item-4","Name":"Shoes","Price":"2000"],
                         ["img":"item-5","Name":"Drone","Price":"12000"]
                         ]
    @IBOutlet weak var CartListTableView: UITableView!
    @IBOutlet weak var lblSubtotalPrice: UILabel!
    @IBOutlet weak var lblShippingCharge: UILabel!
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CartListTableView.delegate = self
        CartListTableView.dataSource = self

    }
    
    // MARK: - Tableview methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CartListTableView.dequeueReusableCell(withIdentifier: "CartItemTableViewCell", for: indexPath) as! CartItemTableViewCell
        cell.removeItemDelegate = self
        cell.imgItem.image = UIImage(named: "\(cartItemArray[indexPath.row]["img"]!)")
        cell.lblItemName.text = cartItemArray[indexPath.row]["Name"]
        cell.itemPrice = Int(cartItemArray[indexPath.row]["Price"]!) ?? 1
        cell.lblItemPrice.text = cartItemArray[indexPath.row]["Price"]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //remove item from cart
    func removeItemFromCart(sender: UIButton) {
        cartItemArray.remove(at: sender.tag)
        CartListTableView.reloadData()
    }

}
