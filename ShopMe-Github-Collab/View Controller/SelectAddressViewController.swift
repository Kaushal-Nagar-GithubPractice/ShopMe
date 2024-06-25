//
//  SelectAddressViewController.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 24/06/24.
//

import UIKit

class SelectAddressViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SendAddress {
    
    var delegatePassAddress:SendAddressToCheckout?
    
    var addressArray = [["CustomerName":"Prasiddh Barot","fullAddress":"11,Gundel,Khedbrahma,Sabarkantha,Gujarat - 383270","Mobile":"6868668668"],
                        ["CustomerName":"Prasiddh Barot","fullAddress":"11,Gundel,Khedbrahma,Sabarkantha,Gujarat - 383270","Mobile":"6868668668"],
                        ["CustomerName":"Prasiddh Barot","fullAddress":"11,Gundel,Khedbrahma,Sabarkantha,Gujarat - 383270","Mobile":"6868668668"]]
    
    
    @IBOutlet weak var AddressListTableView: UITableView!
    
    @IBOutlet weak var ViewHeader: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AddressListTableView.delegate = self
        AddressListTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
//        setUi()
        
    }
    func setUi(){
    
        ViewHeader.clipsToBounds = true
        ViewHeader.layer.cornerRadius = ViewHeader.frame.height/2
        ViewHeader.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner ]
        
    }
    // MARK: - IBActions
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickAddNewAddres(_ sender: Any) {
        
        let addAdrs = self.storyboard?.instantiateViewController(withIdentifier: "AddAddressViewController") as! AddAddressViewController
        addAdrs.delegatePassAddress = self
        
        self.navigationController?.pushViewController(addAdrs, animated: true)
    }
    
    // MARK: - Tableview Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AddressListTableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell", for: indexPath) as! AddressTableViewCell
        cell.lblCustomerName.text = addressArray[indexPath.row]["CustomerName"]
        cell.lblAddress.text = addressArray[indexPath.row]["fullAddress"]
        cell.lblMobileNumber.text = addressArray[indexPath.row]["Mobile"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addres = addressArray[indexPath.row]

        //pass address previous screen
        delegatePassAddress?.passAddressToCheckout(address: addres)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func sendAddresToPreviousVc(addrsArr: [String : String]) {
        addressArray.append(addrsArr)
        AddressListTableView.reloadData()
    }
    
}

protocol SendAddressToCheckout {
    func passAddressToCheckout(address : [String:String])
}
