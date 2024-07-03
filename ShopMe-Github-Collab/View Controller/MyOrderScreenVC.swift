//
//  MyOrderScreenVC.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 24/06/24.
//

import UIKit
import SVProgressHUD

class MyOrderScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TvMyOrderTable: UITableView!
    
    var getOrderListViewModel = OrderListingDataViewModel()
    var OrderListData: OrderListing_Main?
    let loader = SVProgressHUD.self
    
    @IBOutlet weak var viewEmptyOrder: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TvMyOrderTable.delegate = self
        TvMyOrderTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        SetUI()
        CallAPIToGetOrderListFromAPI()
    }
    
    //MARK: - All IBAction
    
    @IBAction func OnClickCloseMyOrder(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - All Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrderListData?.data?.orders?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myOrderTableCell") as! myOrderTableCell

        cell.selectionStyle = .none
        
        let Order = OrderListData?.data?.orders?[indexPath.row]

        cell.lblOrderID.text = "# \(Order?._id?.prefix(6) ?? "")"
        cell.lblOrderDate.text = getFormattedDate(DateInString: Order?.createdAt ?? "", FromFormate: "yyyy-MM-dd'T'HH:mm:ssZ", ToFormate: "dd MMM , yyyy")
        cell.lblTotalItem.text = "( Total Item : \(Order?.products?.count ?? 0) )"
        cell.lblTotalPrize.text = "$ \(Order?.totalAmount ?? 0)"
        cell.lblStatus.text = Order?.orderStatus

        
        //TODO: - Change colour of cell and show status image according to Delivery Status
//        if ( MyOrderArr[indexPath.row]["Status"] == "placed" ){
            cell.btnStatusbutton.setImage(UIImage(named: "Placed"), for: .normal)
            cell.btnStatusbutton.tintColor = UIColor.systemGreen
            cell.lblStatus.textColor = UIColor.systemGreen
            cell.VwMyOrderTablebgView.backgroundColor = UIColor(named: "Custom Light Yellow")

            let dashedBorderLayer = cell.VwStatusView.addLineDashedStroke(pattern: [10, 5], radius: 10, color: UIColor.systemGreen.cgColor)
            cell.VwStatusView.layer.addSublayer(dashedBorderLayer)
//        }
//        else{
//            cell.btnStatusbutton.setImage(UIImage(named: "Cancelled"), for: .normal)
//            cell.btnStatusbutton.tintColor = UIColor.systemRed
//            cell.lblStatus.textColor = UIColor.systemRed
//            cell.VwMyOrderTablebgView.backgroundColor = UIColor(named: "Custom Light Red")
//
//            let dashedBorderLayer = cell.VwStatusView.addLineDashedStroke(pattern: [10, 5], radius: 10, color: UIColor.systemRed.cgColor)
//            cell.VwStatusView.layer.addSublayer(dashedBorderLayer)
//        }
        
        return cell
    }
    
    //MARK: - All Defined Functions
    
    func CallAPIToGetOrderListFromAPI(){

        loader.show(withStatus: "Please Wait , \nWe Are Getting Your Data!")
            
        var request =  APIRequest(isLoader: true, method: .get, path: Constant.Get_OrderList_URl, headers: HeaderValue.headerWithToken.value, body: nil)
            
        getOrderListViewModel.CallToGetOrdersData(request: request) { response in
                
            self.OrderListData = response
                DispatchQueue.main.async { [self] in
                    //Execute UI Code on Completion of API Call and getting data
                    UpdateUIData()
                    SetUI()
                    loader.dismiss()
                }
            } error: { error in
                print("========== API Error :",error)
                self.loader.dismiss()
            }
        
        
    }
    
    func UpdateUIData(){
        TvMyOrderTable.reloadData()
    }
 
    func SetUI(){
        self.tabBarController?.tabBar.isHidden =  true
        
        if OrderListData?.data?.orders?.count == 0{
            viewEmptyOrder.isHidden = false
            TvMyOrderTable.isHidden = true
        }
        else{
            viewEmptyOrder.isHidden = true
            TvMyOrderTable.isHidden = false
        }
    }
}

