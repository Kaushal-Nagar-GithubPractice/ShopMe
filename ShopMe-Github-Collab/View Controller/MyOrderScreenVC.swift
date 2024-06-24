//
//  MyOrderScreenVC.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 24/06/24.
//

import UIKit

class MyOrderScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TvMyOrderTable: UITableView!
    
    var MyOrderArr = [["Date":"24 June 2024", "TotalItem":"5", "TotalAmount":"5000.00","Status":"Placed"],
                      ["Date":"20 May 2024", "TotalItem":"2", "TotalAmount":"200.00","Status":"Cancelled"],
                      ["Date":"14 April 2024", "TotalItem":"6", "TotalAmount":"600.00","Status":"Cancelled"],
                      ["Date":"07 Jan 2024", "TotalItem":"7", "TotalAmount":"7000.00","Status":"Placed"],
                      ["Date":"08 Feb 2024", "TotalItem":"9", "TotalAmount":"80.00","Status":"Cancelled"],
                      ["Date":"10 Oct 2024", "TotalItem":"3", "TotalAmount":"20.00","Status":"Placed"],
                      ["Date":"12 Sept 2024", "TotalItem":"1", "TotalAmount":"80000.00","Status":"Placed"],
                      ["Date":"18 Dec 2024", "TotalItem":"8", "TotalAmount":"1100.00","Status":"Cancelled"],
                      ["Date":"25 Nov 2024", "TotalItem":"6", "TotalAmount":"101.00","Status":"Placed"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TvMyOrderTable.delegate = self
        TvMyOrderTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden =  true
    }
    
    //MARK: - All IBAction
    
    @IBAction func OnClickCloseMyOrder(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - All Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyOrderArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myOrderTableCell") as! myOrderTableCell
        
        cell.selectionStyle = .none
        
        cell.lblOrderID.text = "#0000"
        cell.lblOrderDate.text = MyOrderArr[indexPath.row]["Date"]
        cell.lblTotalItem.text = "( \( MyOrderArr[indexPath.row]["TotalItem"] ?? "") Items )"
        cell.lblTotalPrize.text = "$ \(MyOrderArr[indexPath.row]["TotalAmount"] ?? "")"
        cell.lblStatus.text = MyOrderArr[indexPath.row]["Status"]
        
        if ( MyOrderArr[indexPath.row]["Status"] == "Placed" ){
            cell.btnStatusbutton.setImage(UIImage(named: "Placed"), for: .normal)
            cell.btnStatusbutton.tintColor = UIColor.systemGreen
            
            let dashedBorderLayer = cell.VwStatusView.addLineDashedStroke(pattern: [10, 5], radius: 10, color: UIColor.systemGreen.cgColor)
            cell.VwStatusView.layer.addSublayer(dashedBorderLayer)
        }
        else{
            cell.btnStatusbutton.setImage(UIImage(named: "Cancelled"), for: .normal)
            cell.btnStatusbutton.tintColor = UIColor.systemRed
            
            let dashedBorderLayer = cell.VwStatusView.addLineDashedStroke(pattern: [10, 5], radius: 10, color: UIColor.systemRed.cgColor)
            cell.VwStatusView.layer.addSublayer(dashedBorderLayer)
        }
        
        return cell
    }
}
