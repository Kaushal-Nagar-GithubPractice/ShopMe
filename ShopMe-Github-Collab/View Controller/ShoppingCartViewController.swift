//
//  ShoppingCartViewController.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 24/06/24.
//

import UIKit
import Kingfisher
import SVProgressHUD

class ShoppingCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, removeFromCart{
    
    
    // MARK: - Variables and Outlets
    var productId:String = ""
    var userCartViewModel = GetUserCartVM()
    var addProductOnCheckoutViewModel = AddProductsOnChekoutViewModel()
    var usercartObj = [UserCartModel]()
    var cartObj:cartData!
    var productArr = [cart_Products]()
    var loader = SVProgressHUD()
    var shippingCharge = 0
    var cartItemArray = [["img":"item-1","Name":"Canon camera","Price":"60000","TotalItem":"1"]]
    @IBOutlet weak var CartListTableView: UITableView!
    @IBOutlet weak var lblSubtotalPrice: UILabel!
    @IBOutlet weak var lblShippingCharge: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblGrandTotal: UILabel!
    @IBOutlet weak var viewForEmptyCart: UIView!
    @IBOutlet weak var btnProceedToCheckout: UIButton!
    
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        CartListTableView.delegate = self
        CartListTableView.dataSource = self
        SVProgressHUD.setForegroundColor(UIColor.black)
        SVProgressHUD.setBackgroundColor(UIColor(named: "Custom Black - h")!)
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getCartData(urlPath: Constant.getUserCart)
        SVProgressHUD.setDefaultMaskType(.black)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
        
        checkCart()
    }
    
    // MARK: - IBAction
    
    @IBAction func onClickCheckout(_ sender: Any) {
        
        if !UserDefaults.standard.bool(forKey: "IsRedirect"){
        
            let alert = UIAlertController(title: "To Checkout You Must be Logged in!", message: "" , preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Login", style: UIAlertAction.Style.default, handler: { (action) -> Void in
                        self.NavigateToLoginVC()
                    } ))
            alert.addAction(UIAlertAction(title: "No, Continue as Guest!", style: UIAlertAction.Style.default, handler: { (action) -> Void in
                self.NavigateToCheckoutVc()
            } ))
            alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.systemBackground
            alert.view.subviews.first?.subviews.first?.subviews.first?.layer.borderWidth = 0.5
            alert.view.subviews.first?.subviews.first?.subviews.first?.layer.borderColor = UIColor(named: "Custom Black")?.cgColor
            self.present(alert, animated: true, completion: nil)

        }else{

            var newProductArr: [Any] = []
            
            for product in productArr {
                let dict:[String:Any] = ["productId":product.productId ?? "" ,"quantity":product.quantity ?? 0 , "price":product.price ?? 0 , "size": product.size ?? "A" , "color": product.color ?? "black"]
                newProductArr.append(dict)
            }
            
            let productsDict:[String : Any] = ["product": newProductArr]
            updateCartOnCheckout(prod_arr: productsDict)

          
        }

    }
    
    // MARK: - Tableview methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        let cell = CartListTableView.dequeueReusableCell(withIdentifier: "CartItemTableViewCell", for: indexPath) as! CartItemTableViewCell
        cell.removeItemDelegate = self
        cell.selectionStyle = .none
        
        if productArr[indexPath.row].images?.count != 0{
            UIImageView().setImage(imgUrl: productArr[indexPath.row].images?[0] ?? "", imgView: cell.imgItem)
        }else{
            cell.imgItem.image = UIImage(named: "Placeholder")
        }
        cell.lblItemName.text = productArr[index].productName ?? ""
        cell.lblItemPrice.text = "₹\(productArr[index].price ?? 0)"
        cell.lblTotalItemPrice.text = "₹\(productArr[index].totalProductPrice ?? 0)"
        cell.lblQuantity.text = String(describing: productArr[index].quantity ?? 0)
        cell.lblSize.text = productArr[index].size ?? ""
        cell.lblColor.text = productArr[index].color ?? ""
        
        cell.btnDecrease.tag = index
        cell.btnIncrease.tag = index
        cell.btnRemoveItem.tag = index
        
        //closure from table cell
        cell.increaseQuantity = {
            
            let ItemCount = self.productArr[indexPath.row].quantity ?? 0
            if ItemCount < 50{
                self.productArr[indexPath.row].quantity = ItemCount+1

                let lblPrice = (self.productArr[indexPath.row].price! * self.productArr[indexPath.row].quantity!)
                self.productArr[indexPath.row].totalProductPrice = lblPrice
                
                cell.btnDecrease.isEnabled = true
                self.CartListTableView.reloadData()
                
            }else{
                cell.btnIncrease.isEnabled = false
            }
            self.updateTotal()
        }
        
        //closure from table cell
        cell.decreaseQuantity = {
            
            let itemCount = self.productArr[indexPath.row].quantity ?? 1
            if itemCount > 1{
                //                    self.removeItemFromCart(sender: indexPath.row)                      // on 0 item it remove from cart list
                //                }else{
                self.productArr[indexPath.row].quantity = itemCount-1
                let lblPrice = (self.productArr[indexPath.row].price! * self.productArr[indexPath.row].quantity!)
                self.productArr[indexPath.row].totalProductPrice = lblPrice
                self.CartListTableView.reloadData()
                cell.btnIncrease.isEnabled = true
                
            }else{
                cell.btnDecrease.isEnabled = false
            }
            self.updateTotal()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133
    }
    
    // MARK: - Custom Methods
    
    func setUI(){
        btnProceedToCheckout.layer.cornerRadius  = 10
        btnProceedToCheckout.layer.masksToBounds = true
    }
    
    func checkCart(){
        
        if productArr.count == 0{
            CartListTableView.isHidden = true
        }
        else{
            CartListTableView.isHidden = false
        }
    }
    
    // calculate Total price
    func updateTotal(){
        var total:Int = 0
        for product in productArr{
            total += product.totalProductPrice!
        }
        cartObj.totalAmount = total
        lblSubTotal.text = "₹\(cartObj.totalAmount!)"
        lblShippingCharge.text = "₹\(shippingCharge)"
        lblGrandTotal.text = String(describing:(cartObj.totalAmount! + shippingCharge) )
    }

    
    //MARK: - Api call
    
    func getCartData(urlPath: String){
        SVProgressHUD.show()
        let request = APIRequest(isLoader: true, method: .get, path: urlPath, headers: HeaderValue.headerWithToken.value, body: nil)
        userCartViewModel.getCartData(request:request) { [self] response in

            if response.success == true{
                self.cartObj = response.data
                DispatchQueue.main.async {
                    self.productArr = self.cartObj.products ?? []
                    self.updateTotal()
                    self.checkCart()
                    self.CartListTableView.reloadData()
                    SVProgressHUD.dismiss()
                }
            }else{
                SVProgressHUD.dismiss()
                print("=====> get cart response failed!!")
            }
            
        } error: { error in
            print("cart error====",error as Any)
        }
        
    }
    
    //remove item from cart
    func removeItemFromCart(sender: Int ) {
        
        let prod_Id = productArr[sender]._id
        let urlPath = Constant.deleteProductFromCart+"/\(prod_Id!)"
        
        let request = APIRequest(isLoader: true, method: .delete, path: urlPath, headers: HeaderValue.headerWithToken.value, body: nil)
        userCartViewModel.deleteProduct(request: request) { response in
    
            DispatchQueue.main.async {
                
                self.getCartData(urlPath: Constant.getUserCart)
            }
        } error: {error in
            print("error in delete", error as Any)
        }
        updateTotal()
        
    }
    

    func updateCartOnCheckout(prod_arr : [String:Any]){
        
        SVProgressHUD.show()
        let request = APIRequest(isLoader: true, method: HTTPMethods.post, path: Constant.getUserCart, headers: HeaderValue.headerWithToken.value, body: prod_arr)
        addProductOnCheckoutViewModel.addproductOnCheckout(request: request) { response in

            if response.success == true {
                DispatchQueue.main.async {
                    self.NavigateToCheckoutVc()
                    SVProgressHUD.dismiss()
                }
                
            }else{
                print("error in checkout")
                SVProgressHUD.dismiss()
            }
        } error: { error in
            print("error in added to cart on checkout",error!)
            SVProgressHUD.dismiss()
        }
        
    }
    
    func NavigateToCheckoutVc(){
        let checkoutVC = self.storyboard?.instantiateViewController(withIdentifier: "CheckoutViewController") as! CheckoutViewController
        checkoutVC.myOrderArray = self.productArr
        checkoutVC.priceOfItems = (self.cartObj.totalAmount! + self.shippingCharge)
        self.navigationController?.pushViewController(checkoutVC, animated: true)
    }
    
    func NavigateToLoginVC(){
        let storyBoard = UIStoryboard(name: "Authentication", bundle: nibBundle)
        
        let loginVc = storyBoard.instantiateViewController(withIdentifier: "LoginScreenVC") as! LoginScreenVC
        self.navigationController?.pushViewController(loginVc, animated: true)
    }
    
}
