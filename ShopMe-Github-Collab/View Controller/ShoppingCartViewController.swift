//
//  ShoppingCartViewController.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 24/06/24.
//

import UIKit

class ShoppingCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, removeFromCart{
    
    // MARK: - Variables and Outlets
    var shippingCharge = 5
    var cartItemArray = [["img":"item-1","Name":"Canon camera","Price":"60000","TotalItem":"1"],
                         ["img":"item-2","Name":"T-shirt","Price":"1299","TotalItem":"1"],
                         ["img":"item-3","Name":"Lamp","Price":"7700" ,"TotalItem":"1"],
                         ["img":"item-4","Name":"Shoes","Price":"2000" ,"TotalItem":"1"],
                         ["img":"item-5","Name":"Drone","Price":"12000","TotalItem":"1"]
                         ]
    @IBOutlet weak var CartListTableView: UITableView!
    @IBOutlet weak var lblSubtotalPrice: UILabel!
    @IBOutlet weak var lblShippingCharge: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblGrandTotal: UILabel!
    
    
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CartListTableView.delegate = self
        CartListTableView.dataSource = self

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
//        lblShippingCharge.text! = "1000"
        
        updateTotal()
    }
    
    @IBAction func onClickCheckout(_ sender: Any) {
    
        let checkoutVC = self.storyboard?.instantiateViewController(withIdentifier: "CheckoutViewController") as! CheckoutViewController
        checkoutVC.myOrderArray = cartItemArray
        checkoutVC.priceOfItems = Int(lblGrandTotal.text!) ?? 0
        
        self.navigationController?.pushViewController(checkoutVC, animated: true)
    }
    
    // MARK: - Tableview methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CartListTableView.dequeueReusableCell(withIdentifier: "CartItemTableViewCell", for: indexPath) as! CartItemTableViewCell
        cell.removeItemDelegate = self
        
        cell.itemQuantity = Int(cartItemArray[indexPath.row]["TotalItem"]!) ?? 1
        cell.itemPrice = Int(cartItemArray[indexPath.row]["Price"]!) ?? 1
        cell.imgItem.image = UIImage(named: "\(cartItemArray[indexPath.row]["img"]!)")
        cell.lblItemName.text = cartItemArray[indexPath.row]["Name"]
        cell.lblItemPrice.text = String( Int(cartItemArray[indexPath.row]["Price"]!) ?? 0 * (Int(cartItemArray[indexPath.row]["TotalItem"]!) ?? 0))
        cell.lblQuantity.text = cartItemArray[indexPath.row]["TotalItem"]
        cell.btnDecrease.tag = indexPath.row
        cell.btnIncrease.tag = indexPath.row
        cell.btnRemoveItem.tag = indexPath.row
        
        cell.increaseQuantity = {
            
            let ItemCount = Int(self.cartItemArray[indexPath.row]["TotalItem"]!) ?? 0
            self.cartItemArray[indexPath.row]["TotalItem"] = "\(ItemCount+1)"
            self.updateTotal()
            cell.lblItemPrice.text = String(Int(self.cartItemArray[indexPath.row]["Price"]!)! * Int(self.cartItemArray[indexPath.row]["TotalItem"]!)!)
            self.CartListTableView.reloadData()
             
        }
        
        cell.decreaseQuantity = {
            let itemCount = Int(self.cartItemArray[indexPath.row]["TotalItem"]!) ?? 0
            if itemCount > 1 {
                self.cartItemArray[indexPath.row]["TotalItem"] = "\(itemCount-1)"
                self.updateTotal()
                self.CartListTableView.reloadData()

            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // MARK: - Custom Methods
    
    //remove item from cart
    func removeItemFromCart(sender: UIButton) {
        cartItemArray.remove(at: sender.tag)
        updateTotal()
        CartListTableView.reloadData()
    }
    
    
    // calculate Total price
    func updateTotal(){
        var total:Int = 0
        for item in cartItemArray {
            total = total + item["Price"]!.codingKey.intValue! * item ["TotalItem"]!.codingKey.intValue!
        }
        lblSubTotal.text = String(total)
        lblShippingCharge.text = String((total * shippingCharge)/100)
        lblGrandTotal.text = String(total + (Int( lblShippingCharge.text! ) ?? 0) )
    }
    
}
