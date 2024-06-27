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
    var customerAddress = [String:String]()
    var myOrderArray = [ [String:String] ]()
    
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
    
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productTableView.delegate = self
        productTableView.dataSource = self
        
//        let Dict : [[NSDictionary]] = [[]]
//        UserDefaults.standard.set(Dict, forKey: "MyOrder")
        
        //default value for test
        customerAddress = ["CustomerName": "John Carter","fullAddress":"sola gam,SG Highway,Ahmedabad, gujarat - 320001", "Mobile":"9009088877"]
        
        lblDiscount.text = String(priceOfItems*12/100)
        
        updateTableViewHeight()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        lblCustomerName.text = customerAddress["CustomerName"]
        lblAddress.text = customerAddress["fullAddress"]
        lblMobileNumber.text = customerAddress["Mobile"]
        
        
        btnChnageAddress.layer.borderColor = UIColor.gray.cgColor
        btnChnageAddress.layer.cornerRadius = 5
        btnChnageAddress.layer.borderWidth = 1
        btnChnageAddress.clipsToBounds = true
        productTableView.backgroundColor = .systemGray6
        
        setProductBill()
        setRadioButton()
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
//        let StatusArr = ["Placed","Cancelled"]
//        let Status = StatusArr.randomElement() as! String
        
        // navigate to place order screen
        let orderDetailsDict = ["Date":"24 June 2024", "TotalItem":"\(myOrderArray.count)", "TotalAmount":"\(totalAmount)","Status":"Placed"]
        
        if btnPaypal.isSelected || btnDirectCheck.isSelected || btnBankTransfer.isSelected  {
//            showAlert(title: "Success", message: "Order Placed Successfully.")
            NavigateToOrderVc(Dict:orderDetailsDict)
        }else{
            showAlert(title: "Alert", message: "Please select Payment Mode.")
        }
        
//        var MyOrder = orderDetailsArr
//        var PreviousOrder = UserDefaults.standard.object(forKey: "MyOrder") as! Array<Any>
//        var CurrentArr = PreviousOrder.append(MyOrder)
//        UserDefaults.standard.set(CurrentArr, forKey: "MyOrder")
//        orderVC.MyOrderArr.apend(orderDetailsArr)
//        print("========",UserDefaults.standard.object(forKey: "MyOrder"))
        
    }
 
    // MARK: - Tableview Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOrderArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTableView.dequeueReusableCell(withIdentifier: "OrderedItemTableViewCell", for: indexPath) as! OrderedItemTableViewCell
        cell.imgProduct.image = UIImage(named: "\(myOrderArray[indexPath.row]["img"]!)")
        cell.lblProductName.text = myOrderArray[indexPath.row]["Name"]
        cell.lblProductQuantity.text = myOrderArray[indexPath.row]["TotalItem"]
        cell.lblPrice.text = myOrderArray[indexPath.row]["Price"]
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
    
    func setProductBill(){
        lblItemsCount.text = "\(myOrderArray.count) items"
        lblItemsPrice.text = "\(priceOfItems)"
        totalAmount =  priceOfItems - Int(lblDiscount.text!)!
        lblTotalPrice.text = String(totalAmount)
        
    }
    //set table dynamic height
    func updateTableViewHeight() {
        productTableView.layoutIfNeeded()
        heightTableView.constant = productTableView.contentSize.height
    }
    
    func passAddressToCheckout(address: [String : String]) {
        customerAddress = address
    }
    
    func NavigateToOrderVc(Dict:[String:String]){
        
        var CurrentMyOrder = UserDefaults.standard.array(forKey: "MyOrder") as! Array<Dictionary<String,String>>
        CurrentMyOrder.insert(Dict, at: 0)
        UserDefaults.standard.set(CurrentMyOrder, forKey: "MyOrder")
        
        var MyOrderArr = UserDefaults.standard.array(forKey: "MyOrder") as!  Array<Dictionary<String, String>>
        print(MyOrderArr)
        
        UserDefaults.standard.set([], forKey: "MyCart")
        
        self.navigationController?.popViewController(animated: true)

        let alert = UIAlertController(title: "Order Placed Successfully !", message: "" , preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            ProfileScreenVC.Delegate.ChangeToHomeScreen()
        } ))
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
        self.present(alert, animated: true, completion: nil)
 
    }
    
}
