//
//  CheckoutViewController.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 24/06/24.
//

import UIKit

class CheckoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SendAddressToCheckout {
    
    var priceOfItems: Int = 0
    var totalAmount: Int = 0
    var customerAddress = [String:Any]()
    var myOrderArray = [cart_Products]()
    var discount:Int = 0
    var fullName = ""
    var fullAddress = ""
    var paymentMode = ""
    var url = "https://shoppingcart-api.demoserver.biz/order/checkout"
    
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
    
    //    radio buttons
    @IBOutlet weak var btnPaypal: UIButton!
    @IBOutlet weak var btnDirectCheck: UIButton!
    @IBOutlet weak var btnBankTransfer: UIButton!
    
    @IBOutlet weak var btnPlaceOrder: UIButton!
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productTableView.delegate = self
        productTableView.dataSource = self
        
        //default value for test
        customerAddress = ["firstName":"john", "lastName": "carter" , "mobileNo" : "9099009990" ,"email": "john@gmail.com", "addressLine1": "ganesh meridian" ,"addressLine2":"near kargil Petrol Pump" ,"country": "India" ,"city": "AHmedabad" ,"state": "Gujarat","zipcode" : 1111]
        
        lblDiscount.text = String(priceOfItems * discount/100)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
        setAddress()
        setUi()
        setProductBill()
        setRadioButton()
        updateTableViewHeight()
    }
    
    func setUi(){
        
        btnChnageAddress.layer.borderColor = UIColor.gray.cgColor
        btnChnageAddress.layer.cornerRadius = 5
        btnChnageAddress.layer.borderWidth = 1
        btnChnageAddress.clipsToBounds = true
        productTableView.backgroundColor = .systemGray6
        
        btnPlaceOrder.layer.cornerRadius = 8
        btnPlaceOrder.layer.masksToBounds = true
        
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
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickPlaceOrder(_ sender: Any) {
        
        if btnPaypal.isSelected || btnDirectCheck.isSelected || btnBankTransfer.isSelected  {
            let paymentMode = getPaymentMode()
            let orderDetails = ["billingAddress": customerAddress, "paymentMethod": paymentMode ,"shippingCharge": 100] as [String : Any]
            
            callCheckoutApi(url: url ,method: .post, body: orderDetails)
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
        
        lblItemsCount.text = "\(myOrderArray.count) items"
        lblItemsPrice.text = "\(priceOfItems)"
        totalAmount =  priceOfItems - Int(lblDiscount.text!)!
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
    
    func NavigateToOrderVc(Dict:[String:String]){
        
        var CurrentMyOrder = UserDefaults.standard.array(forKey: "MyOrder") as! Array<Dictionary<String,String>>
        CurrentMyOrder.insert(Dict, at: 0)
        UserDefaults.standard.set(CurrentMyOrder, forKey: "MyOrder")
        
        let MyOrderArr = UserDefaults.standard.array(forKey: "MyOrder") as!  Array<Dictionary<String, String>>
        
        UserDefaults.standard.set([], forKey: "MyCart")
        
        self.navigationController?.popViewController(animated: true)
        
        let alert = UIAlertController(title: "Order Placed Successfully !", message: "" , preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            ProfileScreenVC.Delegate.ChangeToHomeScreen(tabbarItemIndex : 0)
        } ))
        
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
//            print("response on checkout ====>",response)
            
            DispatchQueue.main.async {
                if response.success == true {
                    self.showAlert(title: "Order Placed Successfully!!", message: "")
                }else{
                    self.showAlert(title: "Order failed!!", message: "\(response.message!)")
                }
            }
        } error: { error in
            print("===> error during checkout ===>",error!)
        }
        
    }
    
}
