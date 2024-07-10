//
//  OrderDetailVC.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 04/07/24.
//

import UIKit
import SVProgressHUD

class OrderDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cancelOrderViewModel = CancelOrderViewModel()
    var CancelOrderResponse: Cancel_Order_Main?
    
    
    @IBOutlet weak var lblDeliveryIDLabel: UILabel!
    @IBOutlet weak var lblDelieveryDataLabel: UILabel!
    @IBOutlet weak var lblDelieveryAddNameLabel: UILabel!
    @IBOutlet weak var lblDelieevryAddLabel: UILabel!
    @IBOutlet weak var lblDelieveryPhoneNoLabel: UILabel!
    @IBOutlet weak var lblPaymentMethodLabel: UILabel!
    @IBOutlet weak var lblTotalAmountLabel: UILabel!
    @IBOutlet weak var TvOrderDetail: UITableView!
    @IBOutlet weak var TabelHeightConstaint: NSLayoutConstraint!
    @IBOutlet weak var lblDelieveryStatusLabel: UILabel!
    
    @IBOutlet weak var lblDiscountAmount: UILabel!
    @IBOutlet weak var lblOriginalAmount: UILabel!
    @IBOutlet weak var StackViewButtonHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var VwDelieveryStatusView: UIView!
    @IBOutlet weak var DelieveryStatusHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var StackViewButton: UIStackView!
    @IBOutlet weak var ImgPlaced: UIImageView!
    @IBOutlet weak var ImgShipped: UIImageView!
    @IBOutlet weak var ImgOntheWay: UIImageView!
    @IBOutlet weak var ImgDelivered: UIImageView!
    
    var OrderData : OrderListing_Orders!
    
    @IBOutlet weak var VwPlacedToShippedHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TvOrderDetail.delegate = self
        TvOrderDetail.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        UpdateUIData()
        SetUI()
    }
    
    //MARK: - All IBActions
    
    @IBAction func OnClickCloseOrderList(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func OnClickCancleOrder(_ sender: Any){
        CallAPIToCancelOrder(OrderID : OrderData._id ?? "")
    }
    
    //MARK: - Table View Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrderData.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailTabelCell") as! OrderDetailTabelCell
        
        let Product =  OrderData.products?[indexPath.row]
        
        Cell.selectionStyle = .none
        Cell.ImgProductImage.SetImageWithKingFisher(ImageUrl: Product?.image ?? "", imageView: Cell.ImgProductImage)
        Cell.lblProductNameLAbel.text = Product?.productName
        Cell.lblProductPriceLabel.text = "₹ \(Product?.price ?? 0)"
        Cell.lblQauntityLabel.text = "\(Product?.quantity ?? 0)"
        Cell.lblTotalPriceLabel.text = "₹ \(Product?.totalProductPrice ?? 0)"
        
        return Cell
    }
    
    //MARK: - All Defined Functions
    
    func SetUI(){
        
        if (OrderData.orderStatus == "Placed"){
            ImgPlaced.image = UIImage(named: "Radio_Filled")
        }else if (OrderData.orderStatus == "Package Shipped"){
            ImgPlaced.image = UIImage(named: "Radio_Filled")
            ImgShipped.image = UIImage(named: "Radio_Filled")
        }else if (OrderData.orderStatus == "On the way"){
            ImgPlaced.image = UIImage(named: "Radio_Filled")
            ImgShipped.image = UIImage(named: "Radio_Filled")
            ImgOntheWay.image = UIImage(named: "Radio_Filled")
        }else if (OrderData.orderStatus == "Delivered"){
            ImgPlaced.image = UIImage(named: "Radio_Filled")
            ImgShipped.image = UIImage(named: "Radio_Filled")
            ImgOntheWay.image = UIImage(named: "Radio_Filled")
            ImgDelivered.image = UIImage(named: "Radio_Filled")
        }
        
        if (OrderData.orderStatus == "Delivered"){
            StackViewButtonHeightContraint.constant = 0
            StackViewButton.isHidden = true
            DelieveryStatusHeightConstraint.constant = 396
            VwDelieveryStatusView.isHidden = false
        }else if (OrderData.orderStatus == "Cancelled"){
            StackViewButtonHeightContraint.constant = 0
            StackViewButton.isHidden = true
            DelieveryStatusHeightConstraint.constant = 0
            VwDelieveryStatusView.isHidden = true
            lblDelieveryStatusLabel.textColor = .systemRed
        }else{
            StackViewButtonHeightContraint.constant = 45
            StackViewButton.isHidden = false
            DelieveryStatusHeightConstraint.constant = 396
            VwDelieveryStatusView.isHidden = false
        }

        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        
        TabelHeightConstaint.constant = CGFloat((OrderData.products?.count ?? 0) * 120)
        
    }
    
    func CallAPIToCancelOrder(OrderID : String){
        
        SVProgressHUD.show(withStatus: "Please Wait! \nWhile Cancelling Your Order...")
        
        var request =  APIRequest(isLoader: true, method: .post, path: Constant.Cancel_Order_URl + OrderID, headers: HeaderValue.headerWithToken.value, body: nil)
        
        cancelOrderViewModel.CallToCancelOrde(request: request) { response in
            
            self.CancelOrderResponse = response
            DispatchQueue.main.async { [self] in
                //Execute UI Code on Completion of API Call and getting data
                
                if CancelOrderResponse?.success == true{
                    
                    let Alert = UIAlertController(title: CancelOrderResponse?.message ?? "", message: "", preferredStyle: UIAlertController.Style.alert)
                    
                    Alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        //            print("Handle Ok logic here")
                        self.navigationController?.popViewController(animated: true)
                        Alert.dismiss(animated: true)
                    }))
                    Alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.systemBackground
                    Alert.view.subviews.first?.subviews.first?.subviews.first?.layer.borderWidth = 0.5
                    Alert.view.subviews.first?.subviews.first?.subviews.first?.layer.borderColor = UIColor(named: "Custom Black")?.cgColor
                    self.present(Alert, animated: true, completion: nil)
                    
                }else{
                    ShowAlertBox(Title: CancelOrderResponse?.message ?? "", Message: "")
                }
                
                SVProgressHUD.dismiss()
            }
        } error: { error in
            print("========== API Error :",error)
            SVProgressHUD.dismiss()
        }
    }
    
    func UpdateUIData(){
        
        lblDeliveryIDLabel.text = OrderData._id
        //        lblDeliveryStatusLabel.text = "Status : \(OrderData.orderStatus ?? "")"
        lblDelieveryDataLabel.text = getFormattedDate(DateInString: OrderData.createdAt ?? "", FromFormate: "yyyy-MM-dd'T'HH:mm:ssZ", ToFormate: "dd MMM , yyyy")
        lblDelieveryAddNameLabel.text = "\(OrderData.billingAddress?.firstName ?? "") \(OrderData.billingAddress?.lastName ?? "")"
        lblDelieevryAddLabel.text = "\(OrderData.billingAddress?.addressLine1 ?? "") , \(OrderData.billingAddress?.addressLine2 ?? "") , \(OrderData.billingAddress?.city ?? "") , \(OrderData.billingAddress?.state ?? "") , \(OrderData.billingAddress?.country ?? "") - \(OrderData.billingAddress?.zipcode ?? 0)"
        lblDelieveryPhoneNoLabel.text = "\(OrderData.billingAddress?.mobileNo ?? 0)"
        lblPaymentMethodLabel.text = OrderData.paymentMethod
        lblTotalAmountLabel.text = "\(OrderData.totalAmount ?? 0)"
        lblDelieveryStatusLabel.text = OrderData.orderStatus
        lblOriginalAmount.text = "\(OrderData.originalPrice ?? 0)"
        lblDiscountAmount.text = "\(OrderData.discount ?? 0)"
        
    }
    
}
