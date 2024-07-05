//
//  SelectAddressViewController.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 24/06/24.
//

import UIKit

class SelectAddressViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SendAddress {
    
    var delegatePassAddress:SendAddressToCheckout?
    
    var addressArray = [] as [[String:Any]]
    
    // MARK: - IBOutlets
    @IBOutlet weak var AddressListTableView: UITableView!
    @IBOutlet weak var ViewHeader: UIView!
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AddressListTableView.delegate = self
        AddressListTableView.dataSource = self
        
        addressArray = [["firstName":"john", "lastName": "carter" , "mobileNo" : "9099009990" ,"email": "john@gmail.com", "addressLine1": "ganesh meridian" ,"addressLine2":"near kargil Petrol Pump" ,"country": "India" ,"city": "AHmedabad" ,"state": "Gujarat","zipcode" : 1111]]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
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
    
    
    // MARK: - Delegate
    func sendAddresToPreviousVc(addressDict : [String : Any]) {
        addressArray.append(addressDict)
        AddressListTableView.reloadData()
    }
    
}

extension SelectAddressViewController {
    // MARK: - Tableview Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        let fullName = "\(addressArray[index]["firstName"] ?? "") \(addressArray[index]["lastName"] ?? "")"
        let fullAddress = "\(addressArray[index]["addressLine1"] ?? ""),\(addressArray[index]["addressLine2"] ?? ""),\(addressArray[index]["city"] ?? ""),\(addressArray[index]["state"] ?? ""),\(addressArray[index]["country"] ?? "") -\(addressArray[index]["zipcode"]!)"
        
        let cell = AddressListTableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell", for: indexPath) as! AddressTableViewCell
        cell.lblCustomerName.text = fullName
        cell.lblAddress.text = fullAddress
        cell.lblMobileNumber.text = addressArray[index]["mobileNo"] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let address = addressArray[indexPath.row]
        //pass address previous screen
        delegatePassAddress?.passAddressToCheckout(address: address)
        
        self.navigationController?.popViewController(animated: true)
    }
}

protocol SendAddressToCheckout {
    func passAddressToCheckout(address : [String:Any])
}
