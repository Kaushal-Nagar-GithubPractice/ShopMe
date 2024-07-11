//
//  CheckoutViewController.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 24/06/24.
//

import UIKit
import SVProgressHUD

class CheckoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SendAddressToCheckout, UITextFieldDelegate {
    
    var priceOfItems: Int = 0
    var totalAmount: Int = 0
    var customerAddress = [String:Any]()
    var myOrderArray = [cart_Products]()
    var discount:Int = 0
    var fullName = ""
    var fullAddress = ""
    var paymentMode = ""
    var loader: SVProgressHUD!
    var couponData:Coupon_Data!
    var discountPrice:Int = 0
    
    var isCouponBtnTap = false
    
    // MARK: - IBOutlets
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    @IBOutlet weak var lblItemsCount: UILabel!
    @IBOutlet weak var lblItemsPrice: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var btnChnageAddress: UIButton!
    @IBOutlet weak var viewAddress: UIView!
    
    @IBOutlet weak var tfCouponCode: UITextField!
    @IBOutlet weak var viewCouponTf: UIView!
    @IBOutlet weak var heightCouponView: NSLayoutConstraint!
    //    radio buttons
    @IBOutlet weak var btnPaypal: UIButton!
    @IBOutlet weak var btnDirectCheck: UIButton!
    @IBOutlet weak var btnBankTransfer: UIButton!
    
    @IBOutlet weak var btnPlaceOrder: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //        UserDefaults.standard.set(true, forKey: "IsRedirect")
        productTableView.delegate = self
        productTableView.dataSource = self
        
        self.lblAddress.text = ""
        self.lblCustomerName.text = ""
        self.lblMobileNumber.text = ""
        tfCouponCode.delegate = self
        //        lblDiscount.text = String(priceOfItems * discount/100)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
        setUi()
        setProductBill()
        setRadioButton()
        updateTableViewHeight()
        
        customizeLoader()
        
        Global_scrollView = scrollView
        GregisterKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setUi(){
        productTableView.separatorStyle = .none
        btnChnageAddress.layer.borderColor = UIColor.gray.cgColor
        btnChnageAddress.layer.cornerRadius = 5
        btnChnageAddress.layer.borderWidth = 1
        btnChnageAddress.clipsToBounds = true
        productTableView.backgroundColor = .systemGray6
        
        btnPlaceOrder.layer.cornerRadius = 8
        btnPlaceOrder.layer.masksToBounds = true
        
        if isCouponBtnTap{
            viewCouponTf.isHidden = false
            
            heightCouponView.constant = 0
            UIView.animate(withDuration: 0.2, delay: 0) {
                self.heightCouponView.constant = 50
                self.view.layoutIfNeeded()
            }
            
        }else{
            self.viewCouponTf.isHidden = true
            heightCouponView.constant = 50
            UIView.animate(withDuration: 0.2, delay: 0) {
                self.heightCouponView.constant = 0
                self.view.layoutIfNeeded()
            }
        }
        
    }
    
    // MARK: - IBActions
    @IBAction func onClickChangeAddress(_ sender: Any) {
        
        let selectAddressVc = self.storyboard?.instantiateViewController(withIdentifier: "SelectAddressViewController") as! SelectAddressViewController
        
        selectAddressVc.delegatePassAddress = self
        self.navigationController?.pushViewController(selectAddressVc, animated: true)
    }
    
    @IBAction func onClickRadioBtn(_ sender: UIButton) {
        btnPaypal.isSelected = false
        btnDirectCheck.isSelected = false
        btnBankTransfer.isSelected = false
        
        if sender == btnPaypal{
            btnPaypal.isSelected = true
        }else if sender == btnDirectCheck {
            btnDirectCheck.isSelected = true
        }else{
            btnBankTransfer.isSelected = true
        }
        
    }
    
    @IBAction func onClickAddCoupon(_ sender: Any) {
        isCouponBtnTap = true
        setUi()
    }
    
    @IBAction func onClickApplyCoupon(_ sender: Any) {
        
        //api call
        if tfCouponCode.text! == "" {
            ShowAlertBox(Title: "Please enter coupon code!", Message: "")
        }else{
            let getCouponUrl = Constant.getCoupon+tfCouponCode.text!
            callCouponApi(url : getCouponUrl)
            tfCouponCode.resignFirstResponder()
        }
        
    }
    
    @IBAction func onClickCancleCoupon(_ sender: Any) {
        isCouponBtnTap = false
        tfCouponCode.text = ""
        tfCouponCode.resignFirstResponder()
        discountPrice = 0
        setUi()
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickPlaceOrder(_ sender: Any) {
        
        if !UserDefaults.standard.bool(forKey: "IsRedirect"){
            let alert = UIAlertController(title: "To Place Order You Must be Logged in!", message: "" , preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Login", style: UIAlertAction.Style.default, handler: { (action) -> Void in
                let storyBoard = UIStoryboard(name: "Authentication", bundle: self.nibBundle)
                
                let loginVc = storyBoard.instantiateViewController(withIdentifier: "LoginScreenVC") as! LoginScreenVC
                self.navigationController?.pushViewController(loginVc, animated: true)
            } ))
            alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.systemBackground
            alert.view.subviews.first?.subviews.first?.subviews.first?.layer.borderWidth = 0.5
            alert.view.subviews.first?.subviews.first?.subviews.first?.layer.borderColor = UIColor(named: "Custom Black")?.cgColor
            self.present(alert, animated: true, completion: nil)
        }
        
        if customerAddress.isEmpty{
            showAlert(title: "Please Select Delivery Address!", message: "")
            return
        }
        
        if btnPaypal.isSelected || btnDirectCheck.isSelected || btnBankTransfer.isSelected  {
            let paymentMode = getPaymentMode()
            var orderDetails = ["billingAddress": customerAddress, "paymentMethod": paymentMode ,"shippingCharge": 0 , "coupon": tfCouponCode.text ?? ""] as [String : Any]
            
            orderDetails = orderDetails.filter{$0.value as? String != ""}
            
            callCheckoutApi(url: Constant.checkoutOrder ,method: .post, body: orderDetails)
        }else{
            showAlert(title: "Alert", message: "Please select Payment Mode.")
        }
        
    }
  
    // MARK: - Tableview Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOrderArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = productTableView.dequeueReusableCell(withIdentifier: "OrderedItemTableViewCell", for: indexPath) as! OrderedItemTableViewCell
        let index = indexPath.row
        if myOrderArray[index].images?.count != 0 {
            // set image using kingfisher
            UIImageView().setImage(imgUrl: myOrderArray[index].images?[0] ?? "", imgView: cell.imgProduct)
        }else{
            cell.imgProduct.image = UIImage(named: "Placeholder")
        }
        cell.lblProductName.text = myOrderArray[index].productName!
        cell.lblProductQuantity.text = "\(myOrderArray[index].quantity!)"
        cell.lblPrice.text = "\(myOrderArray[index].totalProductPrice!)"
        cell.lblSize.text = myOrderArray[index].size
        cell.lblColor.text = myOrderArray[index].color
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    // MARK: - Custom Methods
    
    func setRadioButton(){
        btnPaypal.setImage(UIImage.init(named: "radio-button-notSelected"), for: .normal)
        btnDirectCheck.setImage(UIImage.init(named: "radio-button-notSelected"), for: .normal)
        btnBankTransfer.setImage(UIImage.init(named: "radio-button-notSelected"), for: .normal)
        
        btnPaypal.setImage(UIImage.init(named: "radio-button-selected"), for: .selected)
        btnDirectCheck.setImage(UIImage.init(named: "radio-button-selected"), for: .selected)
        btnBankTransfer.setImage(UIImage.init(named: "radio-button-selected"), for: .selected)
    }
    
    func getPaymentMode() -> String {
        if btnPaypal.isSelected == true {
            return (btnPaypal.titleLabel?.text)!
        }else if btnDirectCheck.isSelected == true {
            return (btnDirectCheck.titleLabel?.text)!
        }else if btnBankTransfer.isSelected == true {
            return (btnBankTransfer.titleLabel?.text)!
        }
        return ""
    }
    
    func setProductBill(){
        var payableAmount = 0
        
        //calculate discount price based on discount type
        if couponData?.discountType == "amount"{
            discountPrice = couponData?.discount ?? 0
        }else{
            discountPrice = Int((totalAmount * (couponData?.discount ?? 0))/100)
        }
        
        if discountPrice > priceOfItems {
            payableAmount = 0
        }else{
            payableAmount = priceOfItems - discountPrice
        }
        
        lblItemsCount.text = "\(myOrderArray.count) items"
        lblItemsPrice.text = "\(priceOfItems)"
        lblDiscount.text = "\(discountPrice)"
        totalAmount =  payableAmount
        lblTotalPrice.text = String(totalAmount)
    }
    
    //set table dynamic height
    func updateTableViewHeight() {
        productTableView.layoutIfNeeded()
        heightTableView.constant = CGFloat(myOrderArray.count * 118)
    }
    
    func passAddressToCheckout(address: [String : Any]) {
        customerAddress = address
        setAddress()
    }
    
    func setAddress(){
        fullName = "\(customerAddress["firstName"] ?? "") \(customerAddress["lastName"] ?? "")"
        fullAddress = "\(customerAddress["addressLine1"] ?? ""),\(customerAddress["addressLine2"] ?? ""),\(customerAddress["city"] ?? ""),\(customerAddress["state"] ?? ""),\(customerAddress["country"] ?? "") -\(customerAddress["zipcode"] ?? 0)"
        
        lblCustomerName.text = fullName
        lblAddress.text = fullAddress
        lblMobileNumber.text = "\(customerAddress["mobileNo"] ?? "")"
    }
    
    func NavigateToOrderVc(){
        let alert = UIAlertController(title: "Order placed Successfully!", message: "" , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: {(action:UIAlertAction!) in
            //            self.tabBarController?.selectedIndex = 0
            self.navigationController?.popViewController(animated: true)
        }))
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.systemBackground
        alert.view.subviews.first?.subviews.first?.subviews.first?.layer.borderWidth = 0.5
        alert.view.subviews.first?.subviews.first?.subviews.first?.layer.borderColor = UIColor(named: "Custom Black")?.cgColor
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - API CALL
    
    func callCheckoutApi(url: String ,method: HTTPMethods, body: [String:Any]){
        
        let request = APIRequest(isLoader: true, method: method, path: url, headers: HeaderValue.headerWithToken.value, body: body)
        let checkoutViewModel = AddProductsOnChekoutViewModel()
        
        checkoutViewModel.addproductOnCheckout(request: request) { response in
            
            DispatchQueue.main.async {
                if response.success == true {
                    self.NavigateToOrderVc()
                }else{
                    self.showAlert(title: "Order failed!!", message: "\(response.message!)")
                }
            }
        } error: { error in
            print("===> error during checkout ===>",error as Any)
        }
        
    }
    
    
    func callCouponApi(url : String){
        SVProgressHUD.show()
        let couponViewModel = CouponViewModel()
        let request = APIRequest(isLoader: true, method: HTTPMethods.get, path: url, headers: HeaderValue.headerWithToken.value , body: nil)
        couponViewModel.getCouponDetails(request: request) { response in
            
            DispatchQueue.main.async {
                if response.success == true {
                    self.couponData = response.data
                    print("==> coupon data ===>", self.couponData as Any)
                    self.setProductBill()
                    SVProgressHUD.dismiss()
                    self.ShowAlertBox(Title: "Coupon applied successful", Message: "")
                    
                }else{
                    SVProgressHUD.dismiss()
                    self.ShowAlertBox(Title: "\(response.message!)", Message: "")
                }
            }
        } error: { error in
            print("error while fetching coupon data ==>", error as Any)
        }
        
    }
    
}
