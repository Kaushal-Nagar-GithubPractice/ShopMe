//
//  LoginScreenVC.swift
//  Github_Collab_Task
//
//  Created by webcodegenie on 19/06/24.
//

import UIKit

class LoginScreenVC: UIViewController {
    
    
    @IBOutlet weak var VwLoginBgView: UIView!
    
    @IBOutlet weak var TfPassword: UITextField!
    @IBOutlet weak var TfEmail: UITextField!
    
    @IBOutlet weak var btnShowPassword: UIButton!
    var DoShowPassword = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        SetUI()
        
        if UserDefaults.standard.bool(forKey: "IsRedirect"){
            LoginSuccessfull()
        }
        
        print("\nEmail :", UserDefaults.standard.string(forKey: "Email") ?? "", "\nPassword :",UserDefaults.standard.string(forKey: "Password") ?? "", "\nIsRedirect :",UserDefaults.standard.bool(forKey: "IsRedirect"))
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
        ShowAlertBox(Title: "Login Successfull!", Message: "")
    }
    
    func SetUI(){
        VwLoginBgView.layer.cornerRadius = 10
        VwLoginBgView.layer.borderWidth = 2
        
        DoShowPassword = false
        btnShowPassword.setImage(UIImage(named: "Password Hide"), for: .normal)
        TfPassword.isSecureTextEntry = true
    }

}
