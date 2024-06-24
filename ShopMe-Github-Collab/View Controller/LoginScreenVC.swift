//
//  LoginScreenVC.swift
//  Github_Collab_Task
//
//  Created by webcodegenie on 19/06/24.
//

import UIKit

class LoginScreenVC: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var TfPassword: UITextField!
    @IBOutlet weak var TfEmail: UITextField!
    
    @IBOutlet weak var btnShowPassword: UIButton!
    var DoShowPassword = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.bool(forKey: "IsRedirect"){
            LoginSuccessfull()
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        SetUI()
        registerKeyboardNotifications()
        
        print("\nEmail :", UserDefaults.standard.string(forKey: "Email") ?? "", "\nPassword :",UserDefaults.standard.string(forKey: "Password") ?? "", "\nIsRedirect :",UserDefaults.standard.bool(forKey: "IsRedirect"))
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - All IBActions
    
    @IBAction func OnClickShowAndHidePassword(_ sender: Any) {
        if DoShowPassword{
            DoShowPassword = false
            btnShowPassword.setImage(UIImage(named: "Password Hide"), for: .normal)
            TfPassword.isSecureTextEntry = true
        }
        else{
            DoShowPassword = true
            btnShowPassword.setImage(UIImage(named: "Password Show"), for: .normal)
            TfPassword.isSecureTextEntry = false
        }
    }
    
    @IBAction func OnClickLogin(_ sender: Any) {
        
        if(TfEmail.text?.count == 0 || TfPassword.text?.count == 0){
            ShowAlertBox(Title: "No field should be Empty !", Message: "")
        }
        else if (TfEmail.text?.lowercased() != UserDefaults.standard.string(forKey: "Email") || TfPassword.text?.trimmingCharacters(in: .whitespaces) != UserDefaults.standard.string(forKey: "Password")){
            ShowAlertBox(Title: "InCorrect Creadientials!", Message: "")
        }
        else{
            LoginSuccessfull()
        }
    }
    
    @IBAction func OnClickOpenRegisterScreen(_ sender: Any) {
        let RegisterScreenObj = self.storyboard?.instantiateViewController(withIdentifier: "RegisterScreenVC") as! RegisterScreenVC
        
        self.navigationController?.pushViewController(RegisterScreenObj, animated: true)
    }
    
    //MARK: - All Defined Functions
    
    func LoginSuccessfull(){
        UserDefaults.standard.set(true, forKey: "IsRedirect")
//        ShowAlertBox(Title: "Login Successfull!", Message: "")
        
        let HomeScreen = UIStoryboard(name: "Main", bundle: nibBundle).instantiateViewController(withIdentifier: "CustomTabbarController") as! CustomTabbarController
        
        self.navigationController?.pushViewController(HomeScreen, animated: true)
    }
    
    func SetUI(){
        
        DoShowPassword = false
        btnShowPassword.setImage(UIImage(named: "Password Hide"), for: .normal)
        TfPassword.isSecureTextEntry = true
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
