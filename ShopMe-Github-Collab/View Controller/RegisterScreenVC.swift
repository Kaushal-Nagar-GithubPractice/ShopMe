//
//  RegisterScreenVC.swift
//  Github_Collab_Task
//
//  Created by webcodegenie on 19/06/24.
//

import UIKit

class RegisterScreenVC: UIViewController {
    
    
    @IBOutlet weak var btnRegister: UIButton!
    
    @IBOutlet weak var TfEmail: UITextField!
    @IBOutlet weak var TfPassword: UITextField!
    @IBOutlet weak var TfConfirmPassword: UITextField!
    @IBOutlet weak var TfEnterName: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var btnShowPassword: UIButton!
    var DoShowPassword = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        SetUI()
        registerKeyboardNotifications()
        
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
            TfConfirmPassword.isSecureTextEntry = true
        }
        else{
            DoShowPassword = true
            btnShowPassword.setImage(UIImage(named: "Password Show"), for: .normal)
            TfPassword.isSecureTextEntry = false
            TfConfirmPassword.isSecureTextEntry = false
        }
    }
    
    @IBAction func OnClickRegisterUser(_ sender: Any) {
        
        if(TfEmail.text?.count == 0 || TfPassword.text?.count == 0 || TfConfirmPassword.text?.count == 0 || TfEnterName.text?.count == 0){
            ShowAlertBox(Title: "No field should be Empty !", Message: "")
        }
        else if(!isValidEmail(email: TfEmail.text ?? "")){
            ShowAlertBox(Title: "Enter Valid Email !", Message: "")
        }
        else if( TfPassword.text?.count ?? 0 <= 8 ){
            ShowAlertBox(Title: "Password length should be More than 8 !", Message: "")
        }
        else if ( TfPassword.text?.trimmingCharacters(in: .whitespaces) != TfConfirmPassword.text?.trimmingCharacters(in: .whitespaces)){
            ShowAlertBox(Title: "Password & Confirm Password should be same.", Message: "")
        }
        else{
            SaveIdAndPass()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func OnClickGotoLoginScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - All Defined Functions
    
    func SaveIdAndPass(){
        UserDefaults.standard.set(TfEnterName.text?.trimmingCharacters(in: .whitespaces), forKey: "Username")
        UserDefaults.standard.set(TfEmail.text?.lowercased(), forKey: "Email")
        UserDefaults.standard.set(TfPassword.text?.trimmingCharacters(in: .whitespaces), forKey: "Password")
        UserDefaults.standard.set(false, forKey: "IsRedirect")
    }
    
    func SetUI(){
        TfEmail.text = ""
        TfPassword.text = ""
        TfEnterName.text = ""
        TfConfirmPassword.text = ""
        btnRegister.layer.cornerRadius = 10
        DoShowPassword = false
        btnShowPassword.setImage(UIImage(named: "Password Hide"), for: .normal)
        TfPassword.isSecureTextEntry = true
        TfConfirmPassword.isSecureTextEntry = true
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

extension UIViewController{
    func ShowAlertBox(Title: String , Message : String){
        let Alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        
        Alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            //            print("Handle Ok logic here")
            Alert.dismiss(animated: true)
        }))
        self.present(Alert, animated: true, completion: nil)
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
