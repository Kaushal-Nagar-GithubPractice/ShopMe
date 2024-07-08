//
//  AddAddressViewController.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 24/06/24.


import UIKit

class AddAddressViewController: UIViewController, UITextFieldDelegate {
    
    var delegatePassAddress:SendAddress?
    var isExpand:Bool = false
    
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
    
    var textFields: [UITextField] {
        return [tfFirstName,tfLastName, tfPhoneNumber, tfEmail, tfAddressline1,tfAddressline2,tfCity,tfState,tfCountry,tfZipCode]
    }
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFields.forEach { $0.delegate = self }
        scrollView.contentInset.bottom = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        
        setUi()
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
    
    @objc private func keyboardWillShow(notification: NSNotification){
        guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        scrollView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height + 50
    }
    
    @objc private func keyboardWillHide(notification: NSNotification){
        scrollView.contentInset.bottom = 0
    }
    
    
    // MARK: - IBActions
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickSaveAddress(_ sender: Any) {
        
        if ( tfFirstName.text! == "" || tfLastName.text! == "" || tfPhoneNumber.text! == "" || tfEmail.text! == "" || tfAddressline1.text! == "" || tfAddressline2.text! == "" || tfCity.text! == "" || tfState.text! == "" || tfCountry.text! == "" || tfZipCode.text! == ""){
            
            showAlert(title: "Alert", message: "Please provide the necessary details.")
        }else if (!isValidEmail(email: tfEmail.text ?? "")) {
            showAlert(title: "Please provide Valid Email Address!", message: "")
        }else if(tfPhoneNumber.text?.count != 10){
            showAlert(title: "Mobile number lenght should be 10!", message: "")
        }else{
            let AddressDict:[String:Any] = ["firstName":tfFirstName.text!, "lastName": tfLastName.text! , "mobileNo" : tfPhoneNumber.text! ,"email": tfEmail.text!, "addressLine1": tfAddressline1.text! ,"addressLine2": tfAddressline2.text! ,"country": tfCountry.text! ,"city": tfCity.text! ,"state": tfState.text! ,"zipcode" : Int(tfZipCode.text!) ?? 1111]
            
            
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
