//
//  EditProfileVC.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 24/06/24.
//

import UIKit

class EditProfileVC: UIViewController {
    
    @IBOutlet weak var btnUpdate: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var TfName: UITextField!
    @IBOutlet weak var TfPassword: UITextField!
    @IBOutlet weak var TfEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerKeyboardNotifications()
        btnUpdate.layer.cornerRadius = 10
        self.tabBarController?.tabBar.isHidden =  true
        TfName.text = UserDefaults.standard.string(forKey: "Username")
        TfPassword.text = UserDefaults.standard.string(forKey: "Password")
        TfEmail.text = UserDefaults.standard.string(forKey: "Email")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - All IBAction
    
    @IBAction func OnClickUpdate(_ sender: Any) {
        
        if (TfName.text?.count == 0 || TfEmail.text?.count == 0 || TfPassword.text?.count == 0){
            ShowAlertBox(Title: "No field should be Empty !", Message: "")
        }
        else if(!isValidEmail(email: TfEmail.text ?? "")){
            ShowAlertBox(Title: "Enter Valid Email !", Message: "")
        }
        else if( TfPassword.text?.count ?? 0 <= 8 ){
            ShowAlertBox(Title: "Password length should be More than 8 !", Message: "")
        }
        else{
            SaveData()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func OnClickCloseEditProfile(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - All Defined Functions
    
    func SaveData(){
        UserDefaults.standard.set(TfName.text?.trimmingCharacters(in: .whitespaces), forKey: "Username")
        UserDefaults.standard.set(TfEmail.text?.lowercased(), forKey: "Email")
        UserDefaults.standard.set(TfPassword.text?.trimmingCharacters(in: .whitespaces), forKey: "Password")
        UserDefaults.standard.set(true, forKey: "IsRedirect")
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillShow(notification:)),
                                             name: UIResponder.keyboardWillShowNotification,
                                             object: nil)
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillHide(notification:)),
                                             name: UIResponder.keyboardWillHideNotification,
                                             object: nil)
    }
    
    //MARK: - All Objc Functions
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
}
