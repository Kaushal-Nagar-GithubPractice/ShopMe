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
    @IBOutlet weak var tfFullName: UITextField!
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
            return [tfFullName, tfPhoneNumber, tfEmail, tfAddressline1,tfAddressline2,tfCity,tfState,tfCountry,tfZipCode]
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
//        viewHeader.layer.cornerRadius = 15
//        viewHeader.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner ]
        
        btnSaveAddress.clipsToBounds = true
        btnSaveAddress.layer.cornerRadius = 8
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
        
        if ( tfFullName.text! == "" || tfPhoneNumber.text! == "" || tfEmail.text! == "" || tfAddressline1.text! == "" || tfAddressline2.text! == "" || tfCity.text! == "" || tfState.text! == "" || tfCountry.text! == "" || tfZipCode.text! == ""){
            
            showAlert(title: "Alert", message: "Please provide the necessary details.")
        }else{
            let AddressDict = ["CustomerName":"\(tfFullName.text!)", "fullAddress":"\(tfAddressline1.text!),\(tfAddressline2.text!),\(tfCity.text!),\(tfState.text!),\(tfZipCode.text!)","Mobile":"\(tfPhoneNumber.text!)"]
            delegatePassAddress?.sendAddresToPreviousVc(addrsArr: AddressDict)
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension UIViewController {
    
    func showAlert(title:String , message: String){
        let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
        self.present(alert, animated: true, completion: nil)
    }
}

protocol SendAddress {
    func sendAddresToPreviousVc( addrsArr: [String:String])
}
