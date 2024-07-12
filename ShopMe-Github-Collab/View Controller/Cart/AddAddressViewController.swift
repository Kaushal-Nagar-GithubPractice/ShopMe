//
//  AddAddressViewController.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 24/06/24.


import UIKit

class AddAddressViewController: UIViewController, UITextFieldDelegate {
    
    var delegatePassAddress:SendAddress?
    var isExpand:Bool = false
    var addressType:String?
    
    // MARK: - IBOutlets
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfAddressline1: UITextField!
    @IBOutlet weak var tfAddressline2: UITextField!
    @IBOutlet weak var tfCity: UITextField!
    @IBOutlet weak var tfState: UITextField!
    @IBOutlet weak var tfCountry: UITextField!
    @IBOutlet weak var tfZipCode: UITextField!
    
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var btnSaveAddress: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnOffice: UIButton!
    @IBOutlet weak var btnOther: UIButton!
    var textFields: [UITextField] {
        return [tfFirstName,tfLastName, tfPhoneNumber, tfEmail, tfAddressline1,tfAddressline2,tfCity,tfState,tfCountry,tfZipCode]
    }
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFields.forEach { $0.delegate = self }
//        scrollView.contentInset.bottom = 0

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("===>..u_default adrs arr ===...", UserDefaults.standard.array(forKey: "customeraddress"))
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        Global_scrollView = scrollView
        GregisterKeyboardNotifications()
        
        setUi()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setUi(){
        
        viewHeader.clipsToBounds = true
        btnSaveAddress.clipsToBounds = true
        btnSaveAddress.layer.cornerRadius = 10
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - IBActions
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickselectAddressType(_ sender: UIButton) {
//        btnHome.borderColor = UIColor(named: "Custom Black")
//        btnOffice.borderColor = UIColor(named: "Custom Black")
//        btnOther.borderColor = UIColor(named: "Custom Black")
        
        btnHome.tintColor = UIColor(named: "Custom Black")
        btnOffice.tintColor = UIColor(named: "Custom Black")
        btnOther.tintColor = UIColor(named: "Custom Black")
        
        if sender == btnHome {
            addressType = "home"
            btnHome.tintColor = UIColor.tintColor
        }else if sender == btnOffice{
            addressType = "office"
            btnOffice.tintColor = UIColor.tintColor
            
        }else{
            addressType = "other"

            btnOther.tintColor = UIColor.tintColor
        }
    }
    @IBAction func onClickSaveAddress(_ sender: Any) {
     
        if ( tfFirstName.text! == "" || tfLastName.text! == "" || tfPhoneNumber.text! == "" || tfEmail.text! == "" || tfAddressline1.text! == "" || tfAddressline2.text! == "" || tfCity.text! == "" || tfState.text! == "" || tfCountry.text! == "" || tfZipCode.text! == "" ){
            
            showAlert(title: "Alert", message: "Please provide the necessary details.")
        }else if (!isValidEmail(email: tfEmail.text ?? "")) {
            showAlert(title: "Please provide Valid Email Address!", message: "")
        } else if( tfPhoneNumber.text?.count != 10 ){
            showAlert(title: "Mobile number lenght should be 10!", message: "\((tfPhoneNumber.text! as NSString).integerValue), \(type(of: (tfPhoneNumber.text! as NSString).integerValue))")
        } else if ( Int(tfPhoneNumber.text ?? "") == nil){
            showAlert(title: "Mobile Number Should be Number", message: "")
        } else {
            let AddressDict:[String:Any] = ["firstName":tfFirstName.text!, "lastName": tfLastName.text! , "mobileNo" : tfPhoneNumber.text! ,"email": tfEmail.text!, "addressLine1": tfAddressline1.text! ,"addressLine2": tfAddressline2.text! ,"country": tfCountry.text! ,"city": tfCity.text! ,"state": tfState.text! ,"zipcode" : Int(tfZipCode.text!) ?? 00 , "addressType": addressType ?? "other"]
           
            if UserDefaults.standard.bool(forKey: "firstTimeAddress"){
                var addressArr: [[String:Any]] = UserDefaults.standard.array(forKey: "customeraddress") as! [[String : Any]]
                addressArr.append(AddressDict)
                UserDefaults.standard.set(addressArr, forKey: "customeraddress")
                
            }else{
                print("not saved in user default bcz not logged in")
            }
            
            delegatePassAddress?.sendAddresToPreviousVc(addressDict: AddressDict)
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension UIViewController {
    
    func showAlert(title:String , message: String){
        let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.systemBackground
        alert.view.subviews.first?.subviews.first?.subviews.first?.layer.borderWidth = 0.5
        alert.view.subviews.first?.subviews.first?.subviews.first?.layer.borderColor = UIColor(named: "Custom Black")?.cgColor
        self.present(alert, animated: true, completion: nil)
    }
}

protocol SendAddress {
    func sendAddresToPreviousVc( addressDict : [String:Any])
}