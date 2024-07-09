//
//  OrderDetailVC.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 04/07/24.
//

import UIKit

class OrderDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var VwDelieveryHeaderView: UIView!
    @IBOutlet weak var imgDelieveryBox: UIImageView!
    @IBOutlet weak var lblDeliveryIDLabel: UILabel!
    @IBOutlet weak var lblDeliveryStatusLabel: UILabel!
    @IBOutlet weak var lblDelieveryDataLabel: UILabel!
    @IBOutlet weak var lblDelieveryAddNameLabel: UILabel!
    @IBOutlet weak var lblDelieevryAddLabel: UILabel!
    @IBOutlet weak var lblDelieveryPhoneNoLabel: UILabel!
    @IBOutlet weak var lblPaymentMethodLabel: UILabel!
    @IBOutlet weak var lblTotalAmountLabel: UILabel!
    @IBOutlet weak var TvOrderDetail: UITableView!
    @IBOutlet weak var TabelHeightConstaint: NSLayoutConstraint!
    
    var OrderData : OrderListing_Orders!
    
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
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        
        TabelHeightConstaint.constant = CGFloat((OrderData.products?.count ?? 0) * 120)
        
        imgDelieveryBox.layer.cornerRadius = 10
        
        VwDelieveryHeaderView.layer.cornerRadius = 10
        VwDelieveryHeaderView.layer.masksToBounds = true
    }
    
    func UpdateUIData(){
        
        lblDeliveryIDLabel.text = OrderData._id
        lblDeliveryStatusLabel.text = "Status : \(OrderData.orderStatus ?? "")"
        lblDelieveryDataLabel.text = getFormattedDate(DateInString: OrderData.createdAt ?? "", FromFormate: "yyyy-MM-dd'T'HH:mm:ssZ", ToFormate: "dd MMM , yyyy")
        lblDelieveryAddNameLabel.text = "\(OrderData.billingAddress?.firstName ?? "") \(OrderData.billingAddress?.lastName ?? "")"
        lblDelieevryAddLabel.text = "\(OrderData.billingAddress?.addressLine1 ?? "") , \(OrderData.billingAddress?.addressLine2 ?? "") , \(OrderData.billingAddress?.city ?? "") , \(OrderData.billingAddress?.state ?? "") , \(OrderData.billingAddress?.country ?? "") - \(OrderData.billingAddress?.zipcode ?? 0)"
        lblDelieveryPhoneNoLabel.text = "\(OrderData.billingAddress?.mobileNo ?? 0)"
        lblPaymentMethodLabel.text = OrderData.paymentMethod
        lblTotalAmountLabel.text = "\(OrderData.totalAmount ?? 0)"
        
    }

}
