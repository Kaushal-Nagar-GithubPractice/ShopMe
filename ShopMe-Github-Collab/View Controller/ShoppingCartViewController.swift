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
    @IBOutlet weak var viewForEmptyCart: UIView!
    
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CartListTableView.delegate = self
        CartListTableView.dataSource = self

    }
    override func viewWillAppear(_ animated: Bool) {
        
        if !UserDefaults.standard.bool(forKey: "IsRedirect"){
            
            let alert = UIAlertController(title: "To Checkout You Must be Logged in!", message: "" , preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Login", style: UIAlertAction.Style.default, handler: { (action) -> Void in
                self.NavigateToLoginVC()
            } ))
                alert.addAction(UIAlertAction(title: "No, Continue as Guest!", style: UIAlertAction.Style.default, handler: nil))
                alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
                self.present(alert, animated: true, completion: nil)
            
        }
        
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
        
//        lblShippingCharge.text! = "1000"
        
        updateTotal()
    }
    
    @IBAction func onClickCheckout(_ sender: Any) {
        
        if !UserDefaults.standard.bool(forKey: "IsRedirect"){
            
            let alert = UIAlertController(title: "To Checkout You Must be Logged in!", message: "" , preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Login", style: UIAlertAction.Style.default, handler: { (action) -> Void in
                self.NavigateToLoginVC()
            } ))
    
                alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
                self.present(alert, animated: true, completion: nil)
            
        }
       else if cartItemArray.count != 0{
            let checkoutVC = self.storyboard?.instantiateViewController(withIdentifier: "CheckoutViewController") as! CheckoutViewController
            checkoutVC.myOrderArray = cartItemArray
            checkoutVC.priceOfItems = Int(lblGrandTotal.text!) ?? 0
            
            self.navigationController?.pushViewController(checkoutVC, animated: true)
        }else{
            showAlert(title: "Alert", message: "Please First select product to checkout.")
            
        }
        
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
        cell.lblItemPrice.text = String( Int(cartItemArray[indexPath.row]["Price"]!) ?? 0 * (Int(cartItemArray[indexPath.row]["TotalItem"]!) ?? 0))
        cell.lblQuantity.text = cartItemArray[indexPath.row]["TotalItem"]
        cell.btnDecrease.tag = indexPath.row
        cell.btnIncrease.tag = indexPath.row
        cell.btnRemoveItem.tag = indexPath.row
        
        cell.increaseQuantity = {
            
            let ItemCount = Int(self.cartItemArray[indexPath.row]["TotalItem"]!) ?? 0
            self.cartItemArray[indexPath.row]["TotalItem"] = "\(ItemCount+1)"
            cell.lblQuantity.text = self.cartItemArray[indexPath.row]["TotalItem"]
            self.updateTotal()
            cell.itemPrice = Int(self.cartItemArray[indexPath.row]["Price"]!)! * Int(self.cartItemArray[indexPath.row]["TotalItem"]!)!
            let lblPrice = Int(self.cartItemArray[indexPath.row]["Price"]!)! * Int(self.cartItemArray[indexPath.row]["TotalItem"]!)!
            cell.updatelblItemPrice(price:lblPrice)
             
        }
        
        cell.decreaseQuantity = {
            let itemCount = Int(self.cartItemArray[indexPath.row]["TotalItem"]!) ?? 1
                if itemCount == 1{
                    self.removeItemFromCart(sender: indexPath.row)                      // on 0 item it remove from cart list
                }else{
                    self.cartItemArray[indexPath.row]["TotalItem"] = "\(itemCount-1)"
                    cell.lblQuantity.text = self.cartItemArray[indexPath.row]["TotalItem"]
                    let lblPrice = Int(self.cartItemArray[indexPath.row]["Price"]!)! * Int(self.cartItemArray[indexPath.row]["TotalItem"]!)!
                    cell.updatelblItemPrice(price:lblPrice)
                }

                self.updateTotal()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // MARK: - Custom Methods
    
    //remove item from cart
    func removeItemFromCart(sender: Int ) {
        cartItemArray.remove(at: sender )
   
       //hode table on empty cart
        if cartItemArray.count == 0{
            CartListTableView.isHidden = true
        }
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
    
    
    func NavigateToLoginVC(){
        let storyBoard = UIStoryboard(name: "Authentication", bundle: nibBundle)
        
        let loginVc = storyBoard.instantiateViewController(withIdentifier: "LoginScreenVC") as! LoginScreenVC
        self.navigationController?.pushViewController(loginVc, animated: true)
    }
    
}
